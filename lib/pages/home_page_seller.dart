import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint1/pages/profile_page2.dart';
import 'package:sprint1/pages/categories.dart';
import 'package:sprint1/components/singal_products.dart';

import '../components/food.dart';
import 'add_new_items.dart';
import 'edit_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get info about user
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String imageURL = '';

  //logout method
  void logOut() {
    FirebaseAuth.instance.signOut();
  }

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
      .doc(user.email)
      .collection('Rice')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Food.fromJson(doc.data())).toList());

// Used to read the data of Noodle catefory
  Stream<List<Food>> readNoodle() => FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
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
                            'RM ${riceProduct.price.toStringAsFixed(2)}');
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
                            'RM ${noodleProduct.price.toStringAsFixed(2)}');
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

  // Function to read the user's data from Firestore
  Future<void> readUser() async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(user.email);
    // .doc(auth.currentUser?.email);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      final user = snapshot.data();
      setState(() {
        imageURL = user?['imageUrl'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: const Color(0xfff8dae7),
          child: GestureDetector(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white54,
                        radius: 43,
                        child: CircleAvatar(
                            radius: 40,
                            backgroundImage: imageURL.isNotEmpty
                                ? NetworkImage(imageURL)
                                : null),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Welcome!"),
                          SizedBox(height: 7),
                        ],
                      )
                    ],
                  ),
                ),
                listTile(
                    icon: Icons.home_outlined,
                    title: "Home",
                    context: context,
                    nextScreen: const HomePage()),
                listTile(
                    icon: Icons.person_outlined,
                    title: "User Profile",
                    context: context,
                    nextScreen: const ProfilePage()),
                Container(
                  height: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Contact Support"),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Text("Call us: "),
                          SizedBox(
                            width: 10,
                          ),
                          Text("+6010123456"),
                        ],
                      ),
                      const SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            Text("Mail us: "),
                            SizedBox(width: 10),
                            Text("maverick@gmail.com")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: const Color(0xfffd2e6),
        title: const Text('Home Page'),
        actions: [
          IconButton(onPressed: logOut, icon: const Icon(Icons.logout))
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewItems(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    readUser();
  }
}
