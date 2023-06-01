import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint1/pages/seller/profile_page2.dart';
import 'package:sprint1/pages/seller/categories.dart';
import 'package:sprint1/components/singal_products2.dart';

import '../../components/food.dart';

class MenuPage extends StatefulWidget {
  final String email;
  const MenuPage({Key? key, required this.email})
      : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  String imageURL ="";

  Widget listTile(
      {required IconData icon,
      required String title,
      required BuildContext context,
      required Widget nextScreen}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => nextScreen));
      },
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black45),
        ),
      ),
    );
  }

// Used to read the data of Rice category
  Stream<List<Food>> readRice() => FirebaseFirestore.instance
      .collection('users')
      .doc(widget.email)
      .collection('Rice')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Food.fromJson(doc.data())).toList());

// Used to read the data of Noodle catefory
  Stream<List<Food>> readNoodle() => FirebaseFirestore.instance
      .collection('users')
      .doc(widget.email)
      .collection('Noodle')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Food.fromJson(doc.data())).toList());

  Widget buildRicesProduct() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Rices'),
            const Text(
              'View All',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 260,
        child: StreamBuilder<List<Food>>(
            stream: readRice(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
              if (snapshot.hasData) {
                final riceProducts = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: riceProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final riceProduct = riceProducts[index];
                    return SingalProduct(
                      productImage: riceProduct.foodImgUrl,
                      productName: riceProduct.name,
                      productPrice:
                          'RM ${riceProduct.price.toStringAsFixed(2)}',
                      productCategory: riceProduct.category,
                      productId: riceProduct.id,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    ]);
  }

  Widget buildNoodlesProduct() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Noodles'),
            const Text(
              'View All',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 260,
        child: StreamBuilder<List<Food>>(
            stream: readNoodle(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
              if (snapshot.hasData) {
                final noodleProducts = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: noodleProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final noodleProduct = noodleProducts[index];
                    return SingalProduct(
                      productImage: noodleProduct.foodImgUrl,
                      productName: noodleProduct.name,
                      productPrice:
                          'RM ${noodleProduct.price.toStringAsFixed(2)}',
                      productCategory: noodleProduct.category,
                      productId: noodleProduct.id,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: const Color(0xfffd2e6),
        title: const Text('Home Page'),
        actions: [
          //IconButton(onPressed: logOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://citinewsroom.com/wp-content/uploads/2021/07/Food.jpg'),
                    ),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                buildRicesProduct(),
                buildNoodlesProduct(),
                const SizedBox(height: 10)
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.pink[300],
                splashColor: Colors.amber,
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddNewItems(),
                  //   ),
                  // );
                }
                ),
          ),
        ],
      ),
    );
  }

}
