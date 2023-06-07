// qr_page

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprint1/components/constant.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sprint1/pages/customer/cust_page2.dart';
import 'package:sprint1/pages/customer/table_input.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key, required this.status});

  final String status;
  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  String _scanRes = 'unknown';

  void initState() {
    super.initState();
    _scanRes = widget.status;
  }

  Future<void> scanQR() async {
    String qrScanRes;
    try {
      qrScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      debugPrint(qrScanRes);
    } on PlatformException {
      qrScanRes = 'Failed to get platform version';
    }

    if (!mounted) return;

    setState(() {
      _scanRes = qrScanRes;
    });

    int resNum = 0;
    try {
      resNum = int.parse(_scanRes);
    } catch (e) {
      print('Invalide QR code');
      qrScanRes = 'Invalid QR code';
    }

    // To be use to send the QR to the next page
    if (resNum > 0 && resNum < 10) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return CustomerPage(tableNum: resNum);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('This is customer qr page'),
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Action');
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => scanQR(),
                  child: const Text('Start QR scan'),
                ),
                // ElevatedButton(
                //   child: const Text('Test table transition'),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (BuildContext context) {
                //           return TableInput(
                //             tableNum: 0,
                //           );
                //         },
                //       ),
                //     );
                //   },
                // ),
                // ElevatedButton(
                //   child: const Text('Enter customer page'),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (BuildContext context) {
                //           return const CustomerPage();
                //         },
                //       ),
                //     );
                //   },
                // ),
                Text(
                  'Scan result : $_scanRes\n',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
