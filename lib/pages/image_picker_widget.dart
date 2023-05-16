// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  // Function to get image from gallery
  File? image;
  bool uploading = false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No Image Selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Upload image to storage
    Future<String> uploadFile() async {
      File file = File(image!.path);
      String imageName =
          'productImage/${DateTime.now().microsecondsSinceEpoch}';
      String downloadUrl;

      try {
        await FirebaseStorage.instance
            .ref('imageName') // Filename to save in storage
            .putFile(file);
        downloadUrl =
            await FirebaseStorage.instance.ref(imageName).getDownloadURL();
        if (downloadUrl != null) {
          setState(() {
            image = null;
            print(downloadUrl);
          });
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cancelled"),
          ),
        );
      }
      return downloadUrl;
    }

    return Dialog(
      child: Column(
        children: [
          AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Upload Image',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    if (image != null)
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(
                              () {
                                image = null;
                              },
                            );
                          },
                        ),
                      ),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        child: image == null
                            ? Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: Colors.grey,
                              )
                            : Image.file(image!),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (image != null)
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicButton(
                          style: NeumorphicStyle(color: Colors.green),
                          onPressed: () {
                            setState(() {
                              uploading = true;
                              uploadFile().then((url) {
                                if (url != null) {
                                  setState(() {
                                    uploading = false;
                                  });
                                }
                              });
                            });
                          },
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: NeumorphicButton(
                          style: NeumorphicStyle(color: Colors.red),
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: NeumorphicButton(
                        onPressed: () {},
                        style: NeumorphicStyle(
                            color: Theme.of(context).primaryColor),
                        child: Text(
                          'Upload Image',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (uploading)
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
