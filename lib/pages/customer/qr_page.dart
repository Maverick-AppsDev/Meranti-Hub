import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sprint1/pages/customer/cust_page2.dart';

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
    scanQR();
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
    return const Scaffold(
    );
  }
}
