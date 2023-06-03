import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/components/food_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String productName;
  final String productImage;
  final double productPrice;
  int quantity;

  CartItem({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    this.quantity = 1,
  });
}

class Controller extends GetxController {
  var products = 0.obs;
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
  }

  void removeCartItem(int index) {
    cartItems.removeAt(index);
  }

  void incrementItem(String name) {
    int index = returnIndex(name);
    cartItems[index].quantity++;
  }

  void decrementItem(String name) {
    int index = returnIndex(name);
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      removeCartItem(index);
    }
  }

  int returnIndex(String name){
    int index = 0;
    for(int i=0; i < cartItems.length; i++){
      if(name == cartItems[i].productName){
        index = i;
      }
    }
    return index;
  }

  // create the database
  // Future createFoodOrder(FoodOrder food) async {
  //   //final user = auth.currentUser;
  //   //if (user != null) {
  //     final collectRef = FirebaseFirestore.instance
  //         .collection('customer')
  //         .doc('table1')
  //         .collection('order')
  //         .doc();

  //     final docId = collectRef.id;
  //     final foodId = FoodOrder(
  //         id: docId,
  //         name: food.name,
  //         price: food.price,
  //         foodImgUrl: food.foodImgUrl,
  //         quantity: food.quantity);
  //     await collectRef.set(foodId.toJson());
  //   //}
  // }

  // void add(CartItem item) {
  //   final foodOrder = FoodOrder(
  //                     name: item.productName,
  //                     price: item.productPrice,
  //                     foodImgUrl: item.productImage,
  //                     quantity: item.quantity);
  //   createFoodOrder(foodOrder);
  // }

}