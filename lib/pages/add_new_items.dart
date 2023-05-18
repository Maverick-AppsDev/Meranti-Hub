import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import '../services/firebase_services.dart';

class AddNewItems extends StatefulWidget {
  @override
  State<AddNewItems> createState() => _AddNewItemsState();
}

class _AddNewItemsState extends State<AddNewItems> {
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

  var productCategoriesController = TextEditingController();

  var productNameController = TextEditingController();

  var productPriceController = TextEditingController();

  List<String> categoriesList = ['Rice', 'Noodle'];

  @override
  Widget build(BuildContext context) {
    // FirebaseServices services = FirebaseServices();
    // var catProvider = Provider.of<CategoryProvider>(context);
    // catProvider.getCategory('Categories');

    Widget listView({fieldValue, list, textController}) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: Color(0xfffd2e6),
              //iconTheme: IconThemeData(color: Colors.white),
              automaticallyImplyLeading: false,
              title: Text(
                'Food Categories',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      textController.text = list[index];
                      Navigator.pop(context);
                    },
                    title: Text(list[index]),
                  );
                })
          ],
        ),
      );
    }

    var screenWidth;
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Color(0xfffd2e6),
        title: const Text('Add New Page'),
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
                  child: NeumorphicButton(
                    onPressed: () {
                      getImage();
                    },
                    style:
                        NeumorphicStyle(color: Theme.of(context).primaryColor),
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
              height: 40,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return listView(
                          fieldValue: 'Categories',
                          list: categoriesList,
                          textController: productCategoriesController);
                    });
              },
              child: TextFormField(
                  enabled: false, //cannot enter manually now
                  controller: productCategoriesController,
                  decoration: InputDecoration(labelText: 'Product Category'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please complete required field';
                    }
                    return null;
                  }),
            ),
            TextFormField(
                controller: productNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null) {
                    return 'Please complete required field';
                  }
                  return null;
                }),
            TextFormField(
                controller: productPriceController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Product Price'),
                validator: (value) {
                  if (value == null) {
                    return 'Please complete required field';
                  }
                  return null;
                }),
            SizedBox(
              height: 40,
            ),
            Container(
              height: kToolbarHeight,
              width: screenWidth,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(left: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'SAVE',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
