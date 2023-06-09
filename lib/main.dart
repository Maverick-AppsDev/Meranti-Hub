import 'package:firebase_core/firebase_core.dart';
//import 'package:sprint1/pages/auth_page.dart';
import 'package:sprint1/pages/welcome_page.dart';
import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      //home: AuthPage(),
      // body: new Container(
      //   alignment: Alignment.center,
      //   ),
    );
  }
}
