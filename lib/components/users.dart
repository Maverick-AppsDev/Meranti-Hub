import 'dart:io';

class Users {
  final String fullName;
  final String shopName;
  final String email;
  final String phone;
  final File? imageFile;

  Users(
      {required this.fullName,
      required this.shopName,
      required this.email,
      required this.phone,
      required this.imageFile});
}
