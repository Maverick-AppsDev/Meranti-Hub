import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final controller; //access user's input
  final String hintText; //give hint to user on what to type
  final bool obscureText; //hide character when typing pass

  const MainTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade300),
            ),
            fillColor: Colors.red.shade50,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.blueGrey.shade300)),
      ),
    );
  }
}
