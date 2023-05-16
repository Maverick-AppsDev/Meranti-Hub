import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/main_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  // final User user; required this.user;
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final fullName = TextEditingController();
  final shopName = TextEditingController();
  final phoneNumber = TextEditingController();
  File? image;
  final picker = ImagePicker();
  bool isEditing = false;

  Map<String, dynamic> userData = {};

  // Function to get image from gallery
  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Upload the new profile picture to Firebase Storage
      if (image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('users')
            .child(user.uid)
            .child('profile_picture.jpg');
        final uploadTask = storageRef.putFile(image!);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Update the user document with the new image download URL
        await doc.update({
          'fullName': fullName.text,
          'shopName': shopName.text,
          'phoneNumber': phoneNumber.text,
          'profilePictureUrl': downloadUrl,
        });
      } else {
        // If no new image was selected, update the user document with the existing image URL
        await doc.update({
          'fullName': fullName.text,
          'shopName': shopName.text,
          'phoneNumber': phoneNumber.text,
        });
      }

      // Use a Builder widget to get a new context that is a descendant
      // of the current context
      Builder(builder: (BuildContext scaffoldContext) {
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
          const SnackBar(content: Text('Changes saved!')),
        );
        return const SizedBox.shrink();
      });
    }
  }

  // Function to save the changes
  // Future<void> saveChanges() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     final doc = FirebaseFirestore.instance.collection('users').doc(user.uid);
  //     await doc.update({
  //       'fullName': fullName.text,
  //       'shopName': shopName.text,
  //       'phoneNumber': phoneNumber.text,
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Changes saved!')),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // Initialize userData with user's existing data
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      firestore
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            userData = documentSnapshot.data()! as Map<String, dynamic>;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the collection name and document ID
    const collectionName = 'users';
    final documentId = auth.currentUser!.uid;

    // Define the data to be updated
    Map<String, dynamic> data = {
      'Full_Name': fullName.text,
      'Shop_Name': shopName.text,
      'Phone_No': phoneNumber.text,
    };

    // Update the data in Firestore
    firestore.collection(collectionName).doc(documentId).update(data);

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
                    onTap: () async {
                      await getImage();
                    },
                    child: Stack(children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            image != null ? FileImage(image!) : null,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: getImage,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Icon(Icons.camera_alt),
                            ),
                          ))
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
                // Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text(auth.currentUser!.email!,
                //         style: TextStyle(fontSize: 16))),

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
                    onPressed: saveChanges, child: const Text('Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
