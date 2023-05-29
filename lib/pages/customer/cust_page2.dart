//change stuff from here
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint1/components/constant.dart';
import 'package:sprint1/components/shop_model.dart';
import '../../components/users.dart';

class CustomerPage extends StatefulWidget {
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  // final user = FirebaseAuth.instance.currentUser!;
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // String shopImageURL = '';

  // // Used to read the data of Users
  // Stream<List<Users>> readShop() => FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());

  // // Function to read the user's data from Firestore
  // Future<void> readUser() async {
  //   final docUser =
  //       FirebaseFirestore.instance.collection('users').doc(user.email);
  //   // .doc(auth.currentUser?.email);
  //   final snapshot = await docUser.get();

  //   if (snapshot.exists) {
  //     final user = snapshot.data();
  //     setState(() {
  //       shopImageURL = user?['imageUrl'] ?? '';
  //     });
  //   }
  // }

  // Widget to show the shops
  // Widget buildShop() {
  //   return StreamBuilder<List<Users>>(
  //       stream: readShop(),
  //       builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
  //         if (snapshot.hasData) {
  //           final shops = snapshot.data!;
  //           return Expanded(
  //             child: GridView.count(
  //               crossAxisCount: 2,
  //               childAspectRatio: 1.2,
  //               padding: EdgeInsets.symmetric(horizontal: 10),
  //               children: shops.map((user) {
  //                 return ShopModel(
  //                     shopName: user.shopName, shopImage: user.imageUrl);
  //               }).toList(),
  //             ),
  //           );
  //         } else if (snapshot.hasError) {
  //           return Text("Error ${snapshot.error}");
  //         } else {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
          backgroundColor: const Color(0xfffd2e6),
          title: const TextField(
            decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white)),
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // perform search functionality
                })
          ]),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(top: 40),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: Image.asset("lib/images/merantiLogo.png", height: 60),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, Table 1! Ready to order?",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://people.utm.my/faizaljalal/files/2020/01/batch_IMG_6935-2.jpg'),
                      ),
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
            ),
            // buildShop()
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(10),
              children: [
                ShopModel(
                  shopName: "20Fingers",
                  shopImage: "",
                ),
                ShopModel(
                  shopName: "Gudetama Cafe",
                  shopImage: "",
                ),
              ],
            ))
          ]),
    );
  }
}
