import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/main_textfield.dart';
import 'package:image_picker/image_picker.dart';
import '../components/users.dart';
import '../services/after_layout.dart';

class ProfilePage extends StatefulWidget {
  // final User user; required this.user;
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AfterLayoutMixin<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final fullName = TextEditingController();
  final shopName = TextEditingController();
  final phoneNumber = TextEditingController();
  String imageURL = " ";

  //Function to get image from gallery
  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    Reference ref;
    if (imageURL == " ") {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance
          .ref()
          .child('files/' + uniqueFileName + '.jpg');
    } else {
      ref = FirebaseStorage.instance.refFromURL(imageURL);
    }

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      setState(() {
        imageURL = value;
      });
    });
  }

  Future<Users?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.email);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      final user = Users.fromJson(snapshot.data()!);
      fullName.text = user.fullName;
      shopName.text = user.shopName;
      phoneNumber.text = user.phone;
      setState(() {
        imageURL = user.imageUrl;
      });
      return user;
    }
  }

  Future createUser(Users user) async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.email);
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    // Update the data in Firestore
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Color(0xfffd2e6),
        title: const Text('Profle Page'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User profile picture
                GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Stack(children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: ClipOval(
                          // radius: 50,
                          child: imageURL == " "
                              ? const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.white,
                                )
                              : Image.network(imageURL, fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        // child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt),
                        ),
                      )
                      // )
                    ])),

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

                const SizedBox(height: 10),
                // User email
                MainTextField(
                  controller:
                      TextEditingController(text: auth.currentUser?.email),
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // User phone number
                MainTextField(
                  controller: phoneNumber,
                  hintText: 'Phone Number',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                // Save or Edit user information button
                ElevatedButton(
                  child: const Text('Saved'),
                  onPressed: () {
                    final user = Users(
                        fullName: fullName.text,
                        shopName: shopName.text,
                        phone: phoneNumber.text,
                        imageUrl: imageURL);
                    createUser(user);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    readUser();
  }
}
