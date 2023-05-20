import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprint1/pages/edit_items.dart';
import 'package:sprint1/pages/home_page_seller.dart';
import 'package:sprint1/pages/profile_page2.dart';
import '../pages/add_new_items.dart';

class SingalProduct extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productPrice;
  //final Function onTap;
  SingalProduct(
      {required this.productImage,
      required this.productName,
      required this.productPrice});

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
                  //   onTap: onTap,
                  child: Container(
                      height: 150,
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Image.network(productImage, fit: BoxFit.contain),
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
                                        builder: (context) => EditItems(),
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
