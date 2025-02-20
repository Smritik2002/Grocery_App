from turtle import pd
from rest_framework.views import APIView
from django.http import JsonResponse
from django.http import HttpResponse
from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView
from api.models import Profile, ShopItem
from api.models import Rating
from api.serializer import ShopItemSerializer
from api.serializer import RatingSerializer
from api.recommendation import recommend_items
from .serializer import LoginSerializer, RegisterSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken
from .models import ShopItem

# Create your views here.

def api_home(request):
    return HttpResponse("Hello, world. You're at the API home page.")

class ShopItemSerializer(ListCreateAPIView):
    queryset = ShopItem.objects.all()
    serializer_class = ShopItemSerializer
    
    def get_queryset(self):
        queryset = ShopItem.objects.all()
        return queryset
    
class RatingSerializer(ListCreateAPIView):
    queryset = Rating.objects.all()
    serializer_class = RatingSerializer

class Getrecommendations(APIView):
    """
    API endpoint to get recommended items based on a given item ID.
    """
    def get(self, request, item_id):
        recommendations = recommend_items(item_id, 5)
        return JsonResponse({"recommendations": recommendations})

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
        Profile.objects.create(user=user,age=age,interest=interest)
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

def export_shopitems_to_csv(request):
    # Fetch data from database
    items = list(ShopItem.objects.values())  # Convert QuerySet to list of dictionaries

    if not items:
        return JsonResponse({"message": "No shop items found"}, status=404)

    # Convert to DataFrame and save to CSV
    df = pd.DataFrame(items)
    csv_filename = "shop_items.csv"
    df.to_csv(csv_filename, index=False)

    return JsonResponse({"message": f"Data saved to {csv_filename}"}, status=200)