import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sprint1/components/constant.dart';
import 'package:sprint1/components/food_order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Info about user
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Used to read the data of the orders
  Stream<List<FoodOrder>> readOrder() => FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('orders')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => FoodOrder.fromJson(doc.data())).toList());

  // Widget to show the order using a listed boxes
  Widget buildOrder() {
    return StreamBuilder<List<FoodOrder>>(
      stream: readOrder(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final orders = snapshot.data!;
          // Orders by table num
          final Map<int, List<FoodOrder>> groupedOrders = {};
          for (final order in orders) {
            if (groupedOrders.containsKey(order.tableNum)) {
              groupedOrders[order.tableNum]!.add(order);
            } else {
              groupedOrders[order.tableNum] = [order];
            }
          }

          return ListView.builder(
            itemCount: groupedOrders.length,
            itemBuilder: (context, index) {
              final tableNum = groupedOrders.keys.elementAt(index);
              final ordersForTable = groupedOrders[tableNum]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Table $tableNum',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ordersForTable.length,
                    itemBuilder: (context, index) {
                      final order = ordersForTable[index];
                      return Card(
                        child: ListTile(
                          leading: Image.network(order.foodImgUrl),
                          title: Text(order.name),
                          subtitle:
                              Text('RM ${order.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: Icon(Icons.check_circle),
                            iconSize: 40,
                            onPressed: () {
                              // Logic to delete the order
                              // You can call a function here to delete the order
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xfffd2e6),
        title:
            Text("Tracking Order", style: const TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: buildOrder())
        ],
      ),
    );
  }
}
