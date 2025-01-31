import 'dart:convert';
import 'package:ecommerceapp/model/shop_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ShopItem>> getShopItems() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/shopitems/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ShopItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shop items');
    }
  }
Future<List<RatingModel>> ratings() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/rating/'));
  
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => RatingModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load shop items');
  }
}
 Future<List<Recommendation>> fetchRecommendations(int itemId) async {
  final response = await http.get(Uri.parse("http://10.0.2.2:8000/api/recommend/$itemId/"));
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body); // Decode as Map
    final List<dynamic> data = jsonResponse["recommendations"]; // Extract the list
    print(response.body);
    return data.map((json) => Recommendation.fromJson(json)).toList();
  } else {
    throw Exception("Failed to load recommendations");
  }
}
}
