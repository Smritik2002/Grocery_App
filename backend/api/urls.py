

from django.urls import path
from api.views import Getrecommendations, register_user, login, item_visit
from api import views


urlpatterns = [
    path('', views.api_home, name='home'),
    path('shopitems/', views.ShopItemSerializer.as_view()),
    path('recommend/<int:item_id>/', Getrecommendations.as_view(), name='recommend_items'),
    path('register/', register_user, name='register'),
    path('login/', login, name='login'),
    path('add_history/', item_visit, name="item_history")
]
