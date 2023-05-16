import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/main_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import '../components/users.dart';
import 'package:file_picker/file_picker.dart';

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
  //File? image;
  final picker = ImagePicker();
  bool isEditing = false;
  PlatformFile? pickedFile;
  String imageURL = " ";

  //Function to get image from gallery
  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    Reference ref = FirebaseStorage.instance.ref().child('files/');

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        imageURL = value;
      });
    });
  }

  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result == null) return;

  //   setState(() {
  //     pickedFile = result.files.first;
  //   });
  // }

  // Future uploadFile() async {
  //   final path = 'files/myid.jpg';
  //   final file = File(image!.path!);

  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   ref.putFile(file);
  // }

  // Read the data from firebase
  // Stream<List<Users>> readUsers() =>
  //     FirebaseFirestore.instance.collection('users').snapshots().map(
  //         (snapshot) => snapshot.docs.map((doc) => Users.fromJson(doc.data())));

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
    // Define the collection name and document ID
    const collectionName = 'users';
    final documentId = auth.currentUser!.uid;

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
                    onTap: () async {
                      await getImage();
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
                        //   onTap: getImage,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(Icons.camera_alt),
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
                  child: const Text('Saved'),
                  onPressed: () {
                    final user = Users(
                      fullName: fullName.text,
                      shopName: shopName.text,
                      phone: phoneNumber.text,
                      // imageFile: image
                    );
                    createUser(user);
                    //uploadFile();
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
}
