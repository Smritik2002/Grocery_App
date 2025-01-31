


from django.urls import path
from api.views import Getrecommendations

from api import views


urlpatterns = [
    path('', views.api_home, name='home'),  
    path ('shopitems/', views.ShopItemSerializer.as_view()),
    path ('rating/', views.RatingSerializer.as_view()),
    path('recommend/<int:item_id>/', Getrecommendations.as_view(), name='recommend_items'),
]

