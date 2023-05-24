class Users {
  String id;
  final String fullName;
  final String shopName;
  final String phone;
  final String imageUrl;

  Users(
      {this.id = '',
      required this.fullName,
      required this.shopName,
      required this.phone,
      required this.imageUrl});

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'shopName': shopName,
        'phone': phone,
        'imageUrl': imageUrl
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
      id: json['id'],
      fullName: json['fullName'],
      shopName: json['shopName'],
      phone: json['phone'],
      imageUrl: json['imageUrl']);
}
