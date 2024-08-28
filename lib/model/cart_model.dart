import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    ["Apple", "5", "assets/images/apple1.png", Colors.red],
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

  List _filteredItems = [];

  final List _cartItems = [];

  CartModel() {
    _filteredItems = _shopItems;
  }

  get shopItems => _filteredItems;

  get cartItems => _cartItems;

  void addItemsToCart(int index) {
    _cartItems.add(_filteredItems[index]);
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

  void searchItems(String query) {
    if (query.isEmpty) {
      _filteredItems = _shopItems;
    } else {
      _filteredItems = _shopItems
          .where((item) =>
              item[0].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Bubble Sort algorithm to sort items by price
  void sortItemsByPrice(bool ascending) {
    int n = _filteredItems.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        int currentPrice = int.parse(_filteredItems[j][1]);
        int nextPrice = int.parse(_filteredItems[j + 1][1]);

        if ((ascending && currentPrice > nextPrice) ||
            (!ascending && currentPrice < nextPrice)) {
          // Swap items
          var temp = _filteredItems[j];
          _filteredItems[j] = _filteredItems[j + 1];
          _filteredItems[j + 1] = temp;
        }
      }
    }
    notifyListeners();
  }
}
