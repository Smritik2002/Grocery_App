from django.db import models
from django.contrib.auth.models import User
# Create your models here.

class Category(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class ShopItem(models.Model):
    name = models.CharField(max_length=100)
    price = models.IntegerField()
    image = models.CharField(max_length=100)
    color = models.CharField(max_length=100)
    description = models.TextField()
    category = models.ForeignKey(Category, on_delete=models.CASCADE, default=None, null=True)

    def __str__(self):
        return self.name
    
class Rating(models.Model):
    Rating = models.IntegerField()
    ShopItem = models.ForeignKey(ShopItem, on_delete=models.CASCADE)
    def __str__(self):
        return self.ShopItem.name
    
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    age = models.IntegerField()
    interest = models.CharField(max_length=255)