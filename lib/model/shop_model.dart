class ShopItem {
  final int id;
  final String name;
  final double price;
  final String color;
  final String description;
  final int rating;
  final int visitCount;
  final String image;

  ShopItem({
    required this.id,
    required this.name,
    required this.price,
    required this.color,
    required this.description,
    required this.rating,
    required this.visitCount,
    required this.image,
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      id: json['id'].toInt()??"",  // Ensure 'id' is parsed as an int
      name: json['name']??"",
      price: (json['price'] as num).toDouble(), // Convert price to double
      color: json['color']??"",
      description: json['description']??"",
      rating: json['rating'].toInt()??"", // Convert rating to int
      visitCount: json['visit_count'].toInt()??"", // Convert visit_count to int
      image: json['image']??"",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
    };
  }

}

class RatingModel {
  final int id;
  final int rating;
  final int shopItem;

  RatingModel({required this.id, required this.rating, required this.shopItem});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      rating: json['Rating'],
      shopItem: json['ShopItem'],
    );
  }
}
class Recommendation {
  final String name;
  final double score;

  Recommendation({required this.name, required this.score});

  factory Recommendation.fromJson(List<dynamic> json) {
    return Recommendation(
      name: json[0],   // Name is at index 0
      score: json[1],  // Score is at index 1
    );
  }
}