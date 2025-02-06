import 'dart:convert';
import 'package:ecommerceapp/model/shop_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/login/');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password
      }),
    );

    final Map<String, dynamic> responseData = jsonDecode(response.body);
  print(responseData);
  print(response.statusCode);
  print(response.body);
    if (response.statusCode == 200) {
      return {'success': true, 'message': 'Login successful', 'data': responseData};
    } else {
      return {'success': false, 'message': responseData['error'] ?? 'Login failed'};
    }
  }

  Future<Map<String, dynamic>> registerUser(
      String username, String email, String password) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/register/");
    
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "email": email, "password": password}),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to register: ${response.body}");
    }
  }
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
