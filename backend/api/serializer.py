
from api.models import ShopItem
from rest_framework import serializers

class ShopItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShopItem
        fields = '__all__'