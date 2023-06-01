import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint1/components/constant.dart';
import '../../components/shop_model.dart';

class Shop {
  final String shopName;
  final String imageUrl;
  final String email;

  Shop({
    required this.shopName,
    required this.imageUrl,
    required this.email,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopName: json['shopName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      email: json['id'] ?? '',
    );
  }
}

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String shopImageURL = '';

  // Used to read the data of Shops
  Stream<List<Shop>> readShop() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Shop.fromJson(doc.data())).toList());

  // Widget to show the shops
  Widget buildShop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            "Currently Open Stores",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(
          height: 500,
          child: StreamBuilder<List<Shop>>(
            stream: readShop(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Shop>> snapshot) {
              if (snapshot.hasData) {
                final shops = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 10, // Add vertical spacing
                    crossAxisSpacing: 10, // Add horizontal spacing
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: shops.length,
                  itemBuilder: (BuildContext context, int index) {
                    final shop = shops[index];
                    return ShopModel(
                      shopName: shop.shopName,
                      email: shop.email,
                      imageUrl: shop.imageUrl,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

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
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // perform search functionality
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Hello, Table 1! Ready to order?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
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
                buildShop(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}