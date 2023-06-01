import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var products = 0.obs;

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
}
