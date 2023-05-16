import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sprint1/pages/image_picker_widget.dart';
import 'package:sprint1/pages/provider/cat_provider.dart';

import 'firebase_services.dart';

class AddNewItems extends StatelessWidget {
  static const String id = 'rices-product';
  final formKey = GlobalKey<FormState>();

  var productCategoriesController = TextEditingController();
  var productNameController = TextEditingController();
  var productPriceController = TextEditingController();

  validate() {
    if (formKey.currentState!.validate()) {
      print('Validate');
    }
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please complete required fields'),
    //     ),
    //   );
    // }
  }

  List<String> categoriesList = ['Rice', 'Noodle'];

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    var catProvider = Provider.of<CategoryProvider>(context);
    catProvider.getCategory('Categories');

    Widget appBar(title) {
      return AppBar(
          backgroundColor: Color(0xfffd2e6),
          //iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          title: Text('Food Categories',
              style: TextStyle(color: Colors.black, fontSize: 14)));
    }

    Widget listView({fieldValue, list, textController}) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
    // Widget productCategoriesList(list) {
    //   return Dialog(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         // AppBar(
    //         //     backgroundColor: Color(0xfffd2e6),
    //         //     //iconTheme: IconThemeData(color: Colors.white),
    //         //     automaticallyImplyLeading: false,
    //         //     title: Text('Food Categories',
    //         //         style: TextStyle(color: Colors.black, fontSize: 14)))
    //         appBar("Food Categories"),
    //         // Expanded(
    //         //   child: ListView.builder(
    //         //       shrinkWrap: true,
    //         //       itemCount: list.length,
    //         //       itemBuilder: (BuildContext context, int index) {
    //         //         return ListTile(
    //         //           onTap: () {
    //         //           //  textController.text = list[index];
    //         //           },
    //         //           title: Text(list[index]),
    //         //         );
    //         //       }),
    //         // ),
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Color(0xfffd2e6),
        title: const Text('Add New Page'),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text('Add New Food'),
                InkWell(
                  onTap: () {
                    // Lets show list of the cars to select instead of manually typing
                    // Lists from firebase, need to bring those lists here
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
                      decoration:
                          InputDecoration(labelText: 'Product Category*'),
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

                // Upload Image Button
                Divider(
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    // Upload image from here

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ImagePickerWidget();
                        });
                  },
                  child: Neumorphic(
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text('Upload Image'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  validate();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
