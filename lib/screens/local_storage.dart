import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/shop_model.dart'; // Ensure correct import

class LocalStorageService {
  static const String _shopItemsKey = 'shop_items';

  // Save shop items to local storage
  static Future<void> saveShopItems(List<ShopItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> shopItemsJson =
        items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_shopItemsKey, shopItemsJson);
  }

  // Retrieve shop items from local storage
  static Future<List<ShopItem>> getShopItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? shopItemsJson = prefs.getStringList(_shopItemsKey);
    if (shopItemsJson == null) return [];
    return shopItemsJson
        .map((item) => ShopItem.fromJson(jsonDecode(item)))
        .toList();
  }
}
