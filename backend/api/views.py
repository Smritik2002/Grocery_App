from rest_framework.views import APIView
from django.http import JsonResponse
from django.http import HttpResponse
from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView
from api.models import Profile, ShopItem
from api.serializer import ShopItemSerializer
from api.recommendation import GroceryRecommendationSystem
from .serializer import LoginSerializer, RegisterSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken
import pandas as pd
import os

# Create your views here.


def api_home(request):
    return HttpResponse("Hello, world. You're at the API home page.")


class ShopItemSerializer(ListCreateAPIView):
    queryset = ShopItem.objects.all()
    serializer_class = ShopItemSerializer

    def get_queryset(self):
        queryset = ShopItem.objects.all()
        return queryset


class Getrecommendations(APIView):
    """
    API endpoint to get recommended items based on a given item ID.
    """

    def get(self, request, item_id, user_id):
        rec = GroceryRecommendationSystem()
        item = ShopItem.objects.get(id=item_id)
        user_based = rec.recommend_items_for_user(user_id)
        item_based = rec.recommend_similar_items(item.name)
        recommendation = rec.hybrid_recommend_items(item.name, 10)
        return JsonResponse({"recommendations": recommendation})


@api_view(['POST'])
def register_user(request):
    username = request.data.get('username')
    email = request.data.get('email')
    password = request.data.get('password')
    age = request.data.get('age')
    interest = request.data.get('interest')

    if not username or not email or not password:
        return Response({"error": "Username, email, and password are required."}, status=400)

    if User.objects.filter(email=email).exists():
        return Response({"error": "Email already exists."}, status=400)

    user = User.objects.create_user(username=username, email=email, password=password)
    Profile.objects.create(user=user, age=age, interest=interest)
    
    # Correct the directory path
    directory = "E:/Grocery_App/backend/data"
    
    if not os.path.exists(directory):
        os.makedirs(directory)
    
    new_data = pd.DataFrame([[user.id, username, email, age, interest]], columns=[
                            'ID', 'Username', 'Email', 'Age', 'Interest'])
    
    new_data.to_csv(os.path.join(directory, "profiles.csv"), mode='a', header=False, index=False)
    
    return Response({"message": "User registered successfully."}, status=201)

@api_view(['POST'])
def login(request):
    serializer = LoginSerializer(data=request.data)
    if serializer.is_valid():
        email = serializer.validated_data['email']
        password = serializer.validated_data['password']

        # Authenticate the user
        user = authenticate(request, username=email, password=password)
        print(user)
        if user is not None:
            # If authentication is successful, generate JWT tokens
            refresh = RefreshToken.for_user(user)
            return Response({
                "user_id": user.id,
                'access_token': str(refresh.access_token),
                'refresh_token': str(refresh),
                'message': 'Login successful',
            }, status=status.HTTP_200_OK)
        else:
            # If authentication fails
            return Response({
                'error': 'Invalid credentials'
            }, status=status.HTTP_400_BAD_REQUEST)
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["POST"])
def item_visit(request):
    try:
        shop_item_id = request.data.get('shop_item_id', None)
        if not shop_item_id:
            return Response("Shop item id is required", status=status.HTTP_400_BAD_REQUEST)
        shop_item = ShopItem.objects.get(id=shop_item_id)
        shop_item.visit_count += 1
        shop_item.save()
        return Response("Visit history successfully added", status=200)
    except ShopItem.DoesNotExist:
        return Response("Shop Item doesnot exist", status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        return Response(e, status=500)
