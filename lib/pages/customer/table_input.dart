// example of table input

import 'package:flutter/material.dart';
import 'package:sprint1/components/constant.dart';
import 'package:sprint1/pages/customer/cust_page2.dart';
import 'package:sprint1/pages/customer/qr_page.dart';

class TableInput extends StatelessWidget {
  // need input tableNum as passing argument
  const TableInput({super.key, required this.tableNum});

  final int tableNum;

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
