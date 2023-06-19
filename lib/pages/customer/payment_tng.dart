import 'package:flutter/material.dart';
import 'package:sprint1/components/constant.dart';
import 'package:sprint1/pages/customer/payment_page.dart';
import 'package:sprint1/pages/customer/shop_menu.dart';

import 'order_page_cust.dart';

class PaymentTNG extends StatefulWidget {
  final String email;
  final int tableNum;

  const PaymentTNG({super.key, required this.email, required this.tableNum});

  @override
  State<PaymentTNG> createState() => _PaymentTNGState();
}

class _PaymentTNGState extends State<PaymentTNG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: const Color(0xfffd2e6),
          title: const Text('Touch n Go payment'),
          actions: [],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(height: 25),
          Container(
            child: Image(
              image: AssetImage("lib/images/dummy_tng.jpg"),
            ),
          ),
          SizedBox(height: 25),
          Container(
            child: Text("Use the link below to pay"),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(
              "https:link.tngdigital.com.my/thisIsDummyLink",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            alignment: Alignment.center,
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.pink[300], // Set the desired color
              borderRadius:
                  BorderRadius.circular(10), // Set the desired border radius
            ),
            child: ElevatedButton(
              onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName("/menu"));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300],
                elevation: 0, // Remove the button's elevation
              ),
              child: Text(
                "Finish Payment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ])));
  }
}
