// example of table input

import 'package:flutter/material.dart';
import 'package:sprint1/components/constant.dart';
import 'package:sprint1/pages/customer/cust_page2.dart';
import 'package:sprint1/pages/customer/qr_page.dart';

class TableInput extends StatelessWidget {
  // need input tableNum as passing argument
  const TableInput({super.key, required this.tableNum, custName, phoneNum});

  final int tableNum;
  final String custName = 'default';
  final int phoneNum = 0000;

  @override
  Widget build(BuildContext context) {
    if (tableNum > 0 && tableNum < 10) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('This is testing ordering page'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text('This is table' + tableNum.toString()),
                const SizedBox(height: 20),
                // MainTextField(
                // controller: custName,
                // hintText: 'Customer Name',
                // obscureText: true),
                // const SizedBox(height: 20),
                // MainTextField(
                //     controller: phoneNum,
                //     hintText: 'phone Number',
                //     obscureText: true),
              ],
            ),
          ),
        )),
      );
      // return CustomerPage();
    } else {
      return QRPage(status: 'something wrong with table input');
    }
    // return Scaffold(
    //   body: Text(tableNum.toString()),

    // );
  }
}
