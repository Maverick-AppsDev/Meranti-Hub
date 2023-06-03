import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:sprint1/components/bottom_cart_sheet.dart';
import 'package:sprint1/components/singal_products2.dart';
import 'package:sprint1/pages/customer/item_product.dart';
import '../../components/food.dart';
import 'package:sprint1/components/controller.dart';
import 'package:get/get.dart';

class MenuPage extends StatefulWidget {
  final String email;

  const MenuPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String imageURL = "";
  String search = "";
  String shopName = "";
  final Controller c = Get.put(Controller());

  Widget listTile({
    required IconData icon,
    required String title,
    required BuildContext context,
    required Widget nextScreen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
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

  Stream<List<Food>> readRice() => FirebaseFirestore.instance
      .collection('users')
      .doc(widget.email)
      .collection('Rice')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Food.fromJson(doc.data() as Map<String, dynamic>))
          .toList());

  Stream<List<Food>> readNoodle() => FirebaseFirestore.instance
      .collection('users')
      .doc(widget.email)
      .collection('Noodle')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Food.fromJson(doc.data() as Map<String, dynamic>))
          .toList());

  Future<void> fetchShopName() async {
    final shopSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .get();
    if (shopSnapshot.exists) {
      final shopData = shopSnapshot.data();
      setState(() {
        shopName = shopData?['shopName'] ?? '';
      });
    }
  }

  Widget buildRicesProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text('Rices')],
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
                final filterRice = riceProducts.where((riceProduct) =>
                    riceProduct.name
                        .toLowerCase()
                        .contains(search.toLowerCase()));
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterRice.length,
                  itemBuilder: (BuildContext context, int index) {
                    final riceProduct = filterRice.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemProduct(
                              productName: riceProduct.name,
                              productImage: riceProduct.foodImgUrl,
                              productPrice: riceProduct.price,
                            ),
                          ),
                        );
                      },
                      child: SingalProduct(
                        productImage: riceProduct.foodImgUrl,
                        productName: riceProduct.name,
                        productPrice:
                            'RM ${riceProduct.price.toStringAsFixed(2)}',
                        productCategory: riceProduct.category,
                        productId: riceProduct.id,
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
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
            children: const [
              Text('Noodles'),
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
                final filterNoodle = noodleProducts.where((noodleProduct) =>
                    noodleProduct.name
                        .toLowerCase()
                        .contains(search.toLowerCase()));
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterNoodle.length,
                  itemBuilder: (BuildContext context, int index) {
                    final noodleProduct = filterNoodle.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemProduct(
                              productName: noodleProduct.name,
                              productImage: noodleProduct.foodImgUrl,
                              productPrice: noodleProduct.price,
                            ),
                          ),
                        );
                      },
                      child: SingalProduct(
                        productImage: noodleProduct.foodImgUrl,
                        productName: noodleProduct.name,
                        productPrice:
                            'RM ${noodleProduct.price.toStringAsFixed(2)}',
                        productCategory: noodleProduct.category,
                        productId: noodleProduct.id,
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
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
  void initState() {
    super.initState();
    fetchShopName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: const Color(0xfffd2e6),
        title: Text(shopName),
        actions: [],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView(
              children: [
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red.shade300),
                    ),
                    fillColor: Colors.red.shade50,
                    filled: true,
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                  ),
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                ),
                buildRicesProduct(),
                buildNoodlesProduct(),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              child: const Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ),
              backgroundColor: Colors.pink[300],
              splashColor: Colors.amber,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => BottomCartSheet(
                    productName: c.cartItems[0].productName, // Update with the correct product name
                    productImage: c.cartItems[0].productImage, // Update with the correct product image
                    productPrice: c.cartItems[0].productPrice, // Update with the correct product price
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}