import 'package:flutter/material.dart';
import 'package:sprint1/components/rounded_button.dart';
import 'package:sprint1/components/background.dart';
import 'package:sprint1/pages/seller/auth_page.dart';
import 'package:sprint1/components/constant.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sprint1/pages/customer/cust_page2.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();

}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _scanRes = 'unknown';

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
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to Meranti Hub",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "lib/images/merantiLogo.png",
              height: size.height * 0.4,
            ),
            RoundedButton(
              text: "Customer",
              press: () {
                scanQR();
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (BuildContext context) {
                //       return const QRPage(status: 'entered qr page page',);
                //     },
                //   ),
                // );
              },
            ),
            RoundedButton(
              text: "Seller",
              color: kPrimaryLightColor,
              press: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const AuthPage();
                    },
                  ),
                );
                // debugPrint("Seller Button");
              },
            ),
          ],
        ),
      ),
    );
  }
}