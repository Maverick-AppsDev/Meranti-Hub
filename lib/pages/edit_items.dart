import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';

class EditItems extends StatefulWidget {
  @override
  State<EditItems> createState() => EditItemsState();
}

class EditItemsState extends State<EditItems> {
  // Function to get image from gallery
  File? image;
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
    var screenWidth;
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Color(0xfffd2e6),
        title: const Text('Edit Product Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
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
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pink[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      // style:

                      //NeumorphicStyle(color: Theme.of(context).primaryColor),
                      child: Text(
                        'Upload Image',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            textField("Category", "Product Category"),
            textField("Product Name", "Product Name"),
            textField("Product Price", "Product Price"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink.shade300),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(300, 50))),
                onPressed: () {},
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
                ))
            // Container(
            //   height: kToolbarHeight,
            //   width: screenWidth,
            //   margin: const EdgeInsets.only(bottom: 12),
            //   padding: const EdgeInsets.only(left: 11),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(4),
            //     color: Colors.blue,
            //   ),
            //   child: Center(
            //     child: Text(
            //       'SAVE',
            //       style: const TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget textField(String title, String hint) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: TextField(
            cursorColor: Colors.grey,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
