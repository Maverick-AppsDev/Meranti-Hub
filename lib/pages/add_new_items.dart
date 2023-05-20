import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/food.dart';
import '../services/firebase_services.dart';

class AddNewItems extends StatefulWidget {
  @override
  State<AddNewItems> createState() => _AddNewItemsState();
}

class _AddNewItemsState extends State<AddNewItems> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  var productCategoriesController = TextEditingController();
  var productNameController = TextEditingController();
  var productPriceController = TextEditingController();
  List<String> categoriesList = ['Rice', 'Noodle'];
  // Function to get image from gallery
  File? image;
  String foodImg = "";

  // final picker = ImagePicker();

  // Save the image to storage
  Future<void> getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      print('No Image Selected.');
    }

    Reference ref;
    if (foodImg == "") {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance
          .ref()
          .child('productImage/' + uniqueFileName + '.jpg');
    } else {
      ref = FirebaseStorage.instance.refFromURL(foodImg);
    }

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      setState(() {
        foodImg = value;
      });
    });
  }

  // create the database
  Future createFood(Food food) async {
    final user = auth.currentUser;
    if (user != null) {
      final collectRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .collection(food.category)
          .doc();

      final docId = collectRef.id;
      final foodId = Food(
          id: docId,
          category: food.category,
          name: food.name,
          price: food.price,
          foodImgUrl: food.foodImgUrl);
      await collectRef.set(foodId.toJson());
    }
  }

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
                      //     NeumorphicStyle(color: Theme.of(context).primaryColor),
                      // child:
                      child: Text(
                        'Upload Image',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
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
            const SizedBox(height: 40),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink.shade300),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(300, 50))),
                onPressed: () {
                  final food = Food(
                      name: productNameController.text,
                      category: productCategoriesController.text,
                      price: double.parse(productPriceController.text),
                      foodImgUrl: foodImg);
                  createFood(food);
                  Navigator.pop(context);
                },
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
            //     color: Colors.red[300],
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
}
