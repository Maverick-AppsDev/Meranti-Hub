import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItem {
  final String productName;
  final String productImage;
  final double productPrice;
  int quantity;

  CartItem({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.quantity,
  });
}

class Controller extends GetxController {
  var products = 1.obs;
  var cartItems = <CartItem>[].obs;
  double get totalPrice => cartItems.fold(
      0, (sum, item) => sum + (item.productPrice * item.quantity));

  increment() {
    products.value++;
  }

  decrement() {
    if (products.value <= 0) {
      Get.snackbar(
        "Take Order",
        "Please add the food quantity",
        icon: Icon(Icons.alarm),
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 3),
      );
    } else {
      products.value--;
    }
  }

  void addCartItem(CartItem item) {
    // Check if the item already exists in the cart
    final existingItem = cartItems.firstWhereOrNull(
      (cartItem) => cartItem.productName == item.productName,
    );

    if (existingItem != null) {
      // Item already exists, increment its quantity
      existingItem.quantity++;
    } else {
      // Item does not exist, add it to the cart
      cartItems.add(item);
    }
    products.value = 1;
  }

  void removeCartItem(int index) {
    cartItems.removeAt(index);
  }

  void incrementItem(int index) {
    cartItems[index].quantity++;
  }

  void decrementItem(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      removeCartItem(index);
    }
  }
}