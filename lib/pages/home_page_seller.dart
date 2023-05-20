import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sprint1/pages/profile_page2.dart';
//import 'package:sprint1/pages/singal_products.dart';
import 'package:sprint1/pages/categories.dart';
import 'package:sprint1/pages/singal_products.dart';

import 'add_new_items.dart';
import 'edit_items.dart';
import '../components/food.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get info about user
  final user = FirebaseAuth.instance.currentUser!;

  //logout method
  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  Stream<List<Food>> readRice() => FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('Rice')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Food.fromJson(doc.data())).toList());

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
          style: TextStyle(color: Colors.black45),
        ),
      ),
    );
  }

  Widget buildRicesProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rices'),
              Text(
                'View All',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SingalProduct(
                productImage:
                    'https://t3.ftcdn.net/jpg/03/56/05/00/360_F_356050015_66YJS3i1iucf7TqDIVCVKZfifnIrsLdo.jpg',
                productName: "Nasi Lemak Ayam",
                productPrice: "RM 7.00",
              ),
              SingalProduct(
                productImage:
                    'https://resepichenom.com/media/dc1f7e26658201737ba55e8cb9f940e792bc03c1.jpeg',
                productName: "Nasi Goreng Kampung",
                productPrice: "RM 6.00",
              ),
              SingalProduct(
                productImage:
                    'https://i0.wp.com/resepibonda.my/wp-content/uploads/2015/03/nasi-goreng-pattaya.jpg?ssl=1',
                productName: "Nasi Goreng Pattaya",
                productPrice: "RM 7.00",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNoodlesProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Noodles'),
              Text(
                'View All',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SingalProduct(
                productImage:
                    'https://thumbs.dreamstime.com/b/malaysian-cuisine-maggi-goreng-mamak-style-spicy-fried-curry-instant-noodles-asian-ready-to-serve-wooden-dining-table-38740751.jpg',
                productName: "Maggi Goreng",
                productPrice: "RM 6.00",
              ),
              SingalProduct(
                productImage:
                    'https://thumbs.dreamstime.com/b/chinese-malay-indian-fried-mee-noodle-goreng-bee-hoon-breakfast-lunch-dinner-238025675.jpg',
                productName: "Mee Goreng",
                productPrice: "RM 6.00",
              ),
              SingalProduct(
                productImage:
                    'https://www.mstar.com.my/image/830/553?url=https%3A%2F%2Fclips.mstar.com.my%2Fimages%2Fblob%2F6304051E-EB2F-4F2F-9A7C-CA7B6435398A',
                productName: "Bihun Goreng Udang",
                productPrice: "RM 8.00",
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xfff8dae7),
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
                          backgroundColor: Colors.pink,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome!"),
                          SizedBox(
                            height: 7,
                          ),
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
                // listTile(
                //     icon: Icons.add_outlined,
                //     title: "Add New Food Item",
                //     context: context,
                //     nextScreen: AddNewItems()),
                // listTile(
                //     icon: Icons.edit_outlined,
                //     title: "Edit Food Item",
                //     context: context,
                //     nextScreen: EditItems()),
                Container(
                  height: 300,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact Support"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Call us: "),
                          SizedBox(
                            width: 10,
                          ),
                          Text("+6010123456"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text("Mail us: "),
                            SizedBox(
                              width: 10,
                            ),
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
        backgroundColor: Color(0xfffd2e6),
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
                    image: DecorationImage(
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
                child: Icon(
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
}
