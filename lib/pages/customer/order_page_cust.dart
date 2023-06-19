import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sprint1/components/constant.dart';
import 'package:sprint1/components/food_order.dart';

class OrderPage extends StatefulWidget {
  final String email;
  const OrderPage({super.key, required this.email});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Used to read the data of the orders
  Stream<List<FoodOrder>> readOrder() => FirebaseFirestore.instance
      .collection('users')
      .doc(widget.email)
      .collection('orders')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => FoodOrder.fromJson(doc.data())).toList());

  // Widget to show the order using individual Card widgets
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

          if (groupedOrders.isEmpty) {
            return Center(
              child: Text(
                'No orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: groupedOrders.length,
            itemBuilder: (context, index) {
              final tableNum = groupedOrders.keys.elementAt(
                  groupedOrders.length -
                      1 -
                      index); // Reverse the order of keys
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
                  ...ordersForTable.map((order) => Card(
                        child: ListTile(
                          leading: Image.network(order.foodImgUrl),
                          title: Text(order.name),
                          subtitle: Text(order.quantity.toString()),
                        ),
                      )),
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
        title: Text(
          "Tracking Order",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: buildOrder(),
          ),
        ],
      ),
    );
  }
}
