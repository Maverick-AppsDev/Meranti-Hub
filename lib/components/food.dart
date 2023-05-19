class Food {
  String id;
  final String category;
  final String name;
  final double price;
  final String foodImgUrl;

  Food(
      {this.id = '',
      required this.category,
      required this.name,
      required this.price,
      required this.foodImgUrl});

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'name': name,
        'price': price,
        'foodImg': foodImgUrl
      };

  static Food fromJson(Map<String, dynamic> json) => Food(
      id: json['id'],
      category: json['category'],
      name: json['name'],
      price: json['price'],
      foodImgUrl: json['foodImg']);
}
