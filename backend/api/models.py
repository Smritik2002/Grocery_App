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

    def __str__(self):
        return self.name


class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    age = models.IntegerField()
    interest = models.CharField(max_length=255)
