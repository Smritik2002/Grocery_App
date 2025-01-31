from rest_framework.views import APIView
from django.http import JsonResponse
from django.http import HttpResponse
from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView
from api.models import ShopItem
from api.models import Rating
from api.serializer import ShopItemSerializer
from api.serializer import RatingSerializer
from api.recommendation import recommend_items
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
