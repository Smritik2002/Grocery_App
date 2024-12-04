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
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      color: json['color'],
      description: json['description'],
    );
  }
}
