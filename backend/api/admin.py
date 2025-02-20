from django.contrib import admin

from api.models import Rating, ShopItem,Profile

# Register your models here.

admin.site.register(ShopItem)
admin.site.register(Rating)
admin.site.register(Profile)
