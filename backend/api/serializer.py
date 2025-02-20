from api.models import ShopItem
from api.models import Rating,Profile
from rest_framework import serializers
from django.contrib.auth.models import User
import uuid

class ShopItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShopItem
        fields = '__all__'

class RatingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rating
        fields = '__all__'

class RegisterSerializer(serializers.ModelSerializer):
    user_id = serializers.UUIDField(default=uuid.uuid4, read_only=True)
    password = serializers.CharField(write_only=True)
   

    class Meta:
        model = User
        fields = ['user_id', 'username', 'email', 'password', 'age', 'intrests']

    def create(self, validated_data):
        age = validated_data.get("age", 18)  # Default to 18 if not provided
        intrests = validated_data.get("intrests", "None")  # Default to "None"

        user = User.objects.create_user(

            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password']
        )
        Profile.objects.create(user=user,age=age,intrests=intrests)
class LoginSerializer(serializers.Serializer):
    email = serializers.CharField()
    password = serializers.CharField()
