


from django.urls import path

from api import views


urlpatterns = [
    path('', views.api_home, name='home'),  
    path ('shopitems/', views.ShopItemSerializer.as_view()),
]