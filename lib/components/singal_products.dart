import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprint1/pages/seller/edit_items.dart';

class SingalProduct extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final String productId;
  final String productCategory;
  final ImagePicker imagePicker = ImagePicker();
  //final Function onTap;
  SingalProduct(
      {required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productId,
      required this.productCategory});

// allow user to pick image that doesn't start with http
  Future<void> pickImage(BuildContext context) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Handle the picked image
      String imagePath = pickedFile.path;
      // Perform the necessary actions with the imagePath (e.g., save it, update the UI)
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 260,
            width: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImage(context);
                  },
                  child: Container(
                      height: 150,
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: productImage.startsWith('http')
                            ? Image.network(
                                productImage,
                                fit: BoxFit.contain,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  // Display an error icon if the image fails to load
                                  return const Icon(Icons.error);
                                },
                              )
                            : productImage.isNotEmpty
                                ? Image.file(File(productImage),
                                    fit: BoxFit.contain, errorBuilder:
                                        (BuildContext context, Object exception,
                                            StackTrace? stackTrace) {
                                    return const Icon(Icons.error);
                                  })
                                : Icon(Icons.error, color: Colors.grey),
                      )),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Text(
                          productPrice,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditItems(
                                            foodCategory: productCategory,
                                            foodId: productId),
                                      ));
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
