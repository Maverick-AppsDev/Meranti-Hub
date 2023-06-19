import 'package:flutter/material.dart';
import 'package:sprint1/components/constant.dart';

class PaymentTNG extends StatefulWidget {
  const PaymentTNG({super.key});

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            ElevatedButton(
              // redirect to tracking page
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Finish Payment"),
            )
          ],
        ),
      ),
    );
  }
}
