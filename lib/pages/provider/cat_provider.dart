import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  var doc = FirebaseFirestore.instance.collection('Categories');
  // late DocumentSnapshot doc;
  late String selectedCategory;

  getCategory(selectedCat) {
    this.selectedCategory = selectedCat;
    notifyListeners();
  }

  getCatSnapshot(snapshot) {
    doc = snapshot;
    notifyListeners();
  }
}
