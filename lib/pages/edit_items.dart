import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprint1/components/food.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class EditItems extends StatefulWidget {
  final String foodId;
  final String foodCategory;
  const EditItems({Key? key, required this.foodCategory, required this.foodId})
      : super(key: key);

  @override
  State<EditItems> createState() => EditItemsState();
}

class EditItemsState extends State<EditItems> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final user = FirebaseAuth.instance.currentUser!;
  var productCategoriesController = TextEditingController();
  var productNameController = TextEditingController();
  var productPriceController = TextEditingController();
  List<String> categoriesList = ['Rice', 'Noodle'];
  // Function to get image from gallery
  File? image;
  String foodImg = "";

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
      setState(() async {
        foodImg = value;
      });
    });
  }

  Future<Food?> readFood() async {
    final docFood = FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .collection(widget.foodCategory)
        .doc(widget.foodId);
    final snapshot = await docFood.get();

    if (snapshot.exists) {
      final food = Food.fromJson(snapshot.data()!);
      productCategoriesController.text = food.category;
      productNameController.text = food.name;
      productPriceController.text = food.price.toString();
      setState(() {
        foodImg = food.foodImgUrl;
      });
      image = await urlToFile(food.foodImgUrl);
      return food;
    }
  }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  Future updateFood(Food food) async {
    final user = auth.currentUser;
    if (user != null) {
      final collectRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .collection(food.category)
          .doc(food.id);

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
            SizedBox(height: 5),
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
            SizedBox(height: 20),
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
                  updateFood(food);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(height: 20),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink.shade300),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(300, 50))),
                onPressed: () {
                  final deleteRef = FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.email)
                      .collection(widget.foodCategory)
                      .doc(widget.foodId);
                  deleteRef.delete();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 20),
                ))
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
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.pink.shade300,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    readFood();
  }
}
