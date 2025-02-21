from django.db import models
from django.contrib.auth.models import User
from django.core.validators import MaxValueValidator, MinValueValidator
# Create your models here.


class ShopItem(models.Model):
    name = models.CharField(max_length=100)
    price = models.FloatField()
    image = models.CharField(max_length=100)
    color = models.CharField(max_length=100)
    description = models.TextField()
    rating = models.IntegerField(null=True, blank=True, validators=[MinValueValidator(0), MaxValueValidator(5)])
    visit_count = models.IntegerField(default=0)
    image = models.FileField(upload_to='images/', null=True, blank=True)
    def __str__(self):
        return self.name

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    age = models.IntegerField()
    interest = models.CharField(max_length=255)

class AddToCart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    shop_item = models.ForeignKey(ShopItem, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    added_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.shop_item.name} ({self.quantity})"