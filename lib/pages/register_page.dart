import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint1/components/main_button.dart';
import 'package:sprint1/components/main_textfield.dart';
import 'package:sprint1/components/tiles.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text field control
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final confirmPasswordControl = TextEditingController();

  // sign in method
  void signUp() async {
    // loading screen
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // check if confirm pass == original pass
    if (passwordControl.text != confirmPasswordControl.text) {
      Navigator.pop(context);
      wrongInputPopup("Passwords don't match!");
      return;
    }

    //create a new user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
              // logo
              Image.asset(
                'lib/images/merantiLogo.png',
                height: 200,
                width: 200,
              ),

              const SizedBox(height: 25),

              // create account greeting
              const Text(
                'Create a new Meranti Hub account',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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

              // confirm pass field
              MainTextField(
                controller: confirmPasswordControl,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // sign up button
              MainButton(
                text: 'Sign Up',
                onTap: signUp,
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
              // google signup button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  MyTiles(
                    onTap: () => AuthService().signInWithGoogle(),
                    imagePath: 'lib/images/googleLogo.png',
                    text: 'Google Account',
                  ),
                ],
              ),

              const SizedBox(height: 20),
              // already have an account
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Already have an account?',
                    style: TextStyle(color: Colors.pink.shade600)),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Login now',
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
