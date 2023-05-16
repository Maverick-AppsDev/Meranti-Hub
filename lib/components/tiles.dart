import 'package:flutter/material.dart';

class MyTiles extends StatelessWidget {
  final String imagePath;
  final String text;
  final void Function()? onTap;
  const MyTiles(
      {super.key,
      required this.imagePath,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(16),
              color: Colors.white),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: 40,
              ),
              const SizedBox(width: 30),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ));
  }
}
