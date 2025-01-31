class ShopItem {
  final int id;
  final String name;
  final int price;
  final String image;
  final String color;
  final String description;

  ShopItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.color,
    required this.description,
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      id: json['id']?? "",
      name: json['name']??"",
      price: json['price']??"",
      image: json['image']??"",
      color: json['color']??"",
      description: json['description']??"",
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
  final int id;
  final String name;
  final double similarity;

  Recommendation({required this.id, required this.name, required this.similarity});

  // Factory method to create an instance from JSON
  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      id: json['id'],
      name: json['name'],
      similarity: (json['similarity'] as num).toDouble(),
    );
  }
}