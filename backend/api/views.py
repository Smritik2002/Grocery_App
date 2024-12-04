from django.http import HttpResponse
from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView
from api.models import ShopItem
from api.serializer import ShopItemSerializer

# Create your views here.

def api_home(request):
    return HttpResponse("Hello, world. You're at the API home page.")



class ShopItemSerializer(ListCreateAPIView):
    queryset = ShopItem.objects.all()
    serializer_class = ShopItemSerializer
    
    def get_queryset(self):
        queryset = ShopItem.objects.all()
        return queryset
    