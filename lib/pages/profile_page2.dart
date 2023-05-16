import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/main_textfield.dart';
import 'package:image_picker/image_picker.dart';
import '../components/users.dart';

class ProfilePage extends StatefulWidget {
  final Users user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final fullName = TextEditingController();
  final shopName = TextEditingController();
  final phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullName.text = widget.user.fullName;
    shopName.text = widget.user.shopName;
    phoneNumber.text = widget.user.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: const Text('Profle Page'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User profile picture
                const Icon(Icons.person, size: 100),

                const SizedBox(height: 10),
                // User full name
                MainTextField(
                  controller: fullName,
                  hintText: 'Full Name',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                // User shop's name
                MainTextField(
                  controller: shopName,
                  hintText: 'Shop\'s Name',
                  obscureText: false,
                ),

                // User email

                const SizedBox(height: 10),
                // User phone number
                MainTextField(
                  controller: phoneNumber,
                  hintText: 'Phone Number',
                  obscureText: false,
                )
                // Save or Edit user information button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
