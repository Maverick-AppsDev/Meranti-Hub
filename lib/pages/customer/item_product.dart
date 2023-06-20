import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/components/constant.dart';
import 'package:sprint1/components/controller.dart';
import 'package:sprint1/components/bottom_cart_sheet.dart';

class ItemProduct extends StatefulWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  final String email;
  final int tableNum;

  const ItemProduct(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.productPrice, 
      required this.email, 
      required this.tableNum});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xfffd2e6),
        title: const Text('Product'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                height: 350,
                width: double.infinity,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image: AssetImage("lib/images/merantiLogo.png"),
                    image: NetworkImage(widget.productImage),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                height: 260,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 163, 191),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    size: 22,
                                  ),
                                  onPressed: () => c.decrement(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Obx(() => Text(
                                      "${c.products.toString()}",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    size: 22,
                                  ),
                                  onPressed: () => c.increment(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "RM ${widget.productPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add to Cart'),
        icon: const Icon(Icons.add_shopping_cart),
        backgroundColor: Color.fromARGB(255, 240, 98, 146),
        onPressed: () {
          final item = CartItem(productName: widget.productName, productImage: widget.productImage, productPrice: widget.productPrice, quantity: c.products.toInt());
          c.addCartItem(item);
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomCartSheet(email: widget.email, tableNum: widget.tableNum),
          );
        },
      ),
    );
  }
}