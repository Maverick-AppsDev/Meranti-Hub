import 'dart:io';
import 'package:flutter/material.dart';

class ShopModel extends StatelessWidget {
  final String shopName;
  final String shopImage;

  const ShopModel({super.key, required this.shopName, required this.shopImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Go to the shop page
            },
            child: Container(
              height: 150,
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: AspectRatio(
                  aspectRatio: 1.0,
                  // child: Icon(Icons.food_bank, color: Colors.black),
                  child: Image.network(
                    shopImage,
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shopName,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // return Row(children: [
    //   Expanded(
    //       child: Container(
    //           margin: EdgeInsets.symmetric(horizontal: 10),
    //           height: 260,
    //           width: 170,
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //           child: Column(
    //             children: [
    //               GestureDetector(
    //                 onTap: () {
    //                   //go to the shop page
    //                 },
    //                 child: Container(
    //                   height: 150,
    //                   padding: EdgeInsets.all(5),
    //                   width: double.infinity,
    //                   child: AspectRatio(
    //                       aspectRatio: 1.0,
    //                       child: Icon(Icons.food_bank, color: Colors.black)),
    //                 ),
    //               ),
    //               Expanded(
    //                   flex: 2,
    //                   child: Padding(
    //                       padding: const EdgeInsets.symmetric(
    //                           horizontal: 10, vertical: 10),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(shopName,
    //                               style: TextStyle(color: Colors.black)),
    //                           SizedBox(height: 5),
    //                         ],
    //                       )))
    //             ],
    //           )))
    // ]);
  }
}
