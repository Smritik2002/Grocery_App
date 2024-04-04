import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    ["Apple", "15", "assets/images/apple1.png", Colors.red],
    ["Watermelon", "15", "assets/images/watermelon.png", Colors.green],
    ["Banana", "15", "assets/images/banana.png", Colors.yellow],
    ["Orange", "35", "assets/images/orange.png", Colors.orange],
    ["Cherry", "35", "assets/images/cherry1.png", Colors.red],
    ["Chicken", "15", "assets/images/chicken.png", Colors.redAccent],
    ["Cabbage", "15", "assets/images/cabbage.png", Colors.greenAccent],
    ["Potato", "15", "assets/images/potato.png", Colors.brown],
    ["Avocado", "15", "assets/images/avocado.png", Colors.greenAccent],
    ["Litchi", "15", "assets/images/Litchi.png", Colors.redAccent],
  ];

  final List _cartItems = [];

  get shopItems => _shopItems;

  get cartItems => _cartItems;

  void addItemsToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void removeItemsFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
