import 'dart:convert';
import 'package:ecommerceapp/model/shop_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ShopItem>> getShopItems() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/shopitems/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => ShopItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shop items');
    }
  }
}
