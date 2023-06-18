class FoodOrder {
  String id;
  final String name;
  final double price;
  final String foodImgUrl;
  final int quantity;
  final int tableNum;

  FoodOrder(
      {this.id = '',
      required this.name,
      required this.price,
      required this.foodImgUrl,
      required this.quantity,
      required this.tableNum});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'foodImg': foodImgUrl,
        'quantity': quantity,
        'tableNum': tableNum
      };

  static FoodOrder fromJson(Map<String, dynamic> json) => FoodOrder(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      foodImgUrl: json['foodImg'],
      quantity: json['quantity'],
      tableNum: json['tableNum']);
}
