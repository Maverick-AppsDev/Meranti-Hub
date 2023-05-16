import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint1/components/main_button.dart';
import 'package:sprint1/components/main_textfield.dart';
import 'package:sprint1/components/tiles.dart';
import 'package:sprint1/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text field control
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();

  // sign in method
  void signIn() async {
    // loading screen
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // login method, use try and catch exception for wrong email/password
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailControl.text, password: passwordControl.text);

      // pop loading screen
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading screen
      Navigator.pop(context);
      //show error message
      wrongInputPopup(e.code);
    }
  }

  //wrong input popup
  void wrongInputPopup(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.indigo.shade200,
            title: Center(
                child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[100],
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // greet user
              const Text(
                'Welcome to Meranti Hub',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),
              // logo
              Image.asset(
                'lib/images/merantiLogo.png',
                height: 200,
                width: 200,
              ),

              const SizedBox(height: 30),

              // email field => take from main text field file
              MainTextField(
                controller: emailControl,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // pass field
              MainTextField(
                controller: passwordControl,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot pass
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.pink[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // log in button
              MainButton(
                text: 'Sign In',
                onTap: signIn,
              ),

              const SizedBox(height: 25),
              // continue with text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.red[300]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.pink[600]),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 0.5, color: Colors.red[300]),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),
              // google signin button
              // ElevatedButton(
              //   onPressed: () => AuthService().signInWithGoogle(),
              //   child:
              //       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //     Image.asset(
              //       'lib/images/googleLogo.png',
              //       width: 24,
              //       height: 24,
              //     ),
              //     SizedBox(width: 8),
              //     Text('Google',
              //         style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white))
              //   ]),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  MyTiles(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/googleLogo.png',
                      text: 'Google Account'),
                ],
              ),

              const SizedBox(height: 20),
              // register now
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Not a member?',
                    style: TextStyle(color: Colors.pink.shade600)),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold),
                  ),
                )
              ])
            ]),
          ),
        )));
  }
}
