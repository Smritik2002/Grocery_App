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
    if (response.statusCode == 200) {
      print(response.body);
      return {'success': true, 'message': 'Login successful', 'data': responseData};
    } else {
      return {'success': false, 'message': responseData['error'] ?? 'Login failed'};
    }
  }

 Future<Map<String, dynamic>> registerUser(
      String username, String email, String password, int age, String interest) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/register/");
    
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
        "age": age,
        "interest": interest  // Ensure correct spelling as per your Django API
      }),
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
      print(response.body);
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
 Future<List<Recommendation>> fetchRecommendations(int itemId, int user_id) async {
  print(itemId);
  print(user_id);
  final response = await http.get(Uri.parse("http://10.0.2.2:8000/api/recommend/$itemId/$user_id/"));
 if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body); // Decode as Map
    final List<dynamic> data = jsonResponse["recommendations"]; // Extract the list of lists
    
    print(response.body);
    
    return data.map((item) {
      return Recommendation(
        name: item[0],  
        score: item[1], 
      );
    }).toList();
  } else {
    throw Exception("Failed to load recommendations");
  }
}
Future<void> visitItem(int item_id) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/27/');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'shop_item_id': item_id,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success response
      print("Visit history successfully added");
    } else {
      // Log the full response for debugging
      print("Failed to add visit history. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  } catch (e) {
    // Handle exceptions (like network errors)
    print("Error: $e");
  }
}

}