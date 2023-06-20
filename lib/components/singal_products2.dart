import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SingalProduct extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  final String productId;
  final String productCategory;
  final ImagePicker imagePicker = ImagePicker();
  //final Function onTap;
  SingalProduct(
      {super.key,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productId,
      required this.productCategory});

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
              children: [ Container(
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
