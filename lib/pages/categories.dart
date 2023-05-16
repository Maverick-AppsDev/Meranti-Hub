import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprint1/pages/add_new_items.dart';
import 'package:sprint1/pages/firebase_services.dart';
import 'package:sprint1/pages/provider/cat_provider.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    // var catProvider = Provider.of<CategoryProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: services.categories.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            return Container(
              height: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text('Categories',
                              style: TextStyle(color: Colors.grey))),
                      TextButton(
                        onPressed: () {
                          // Show complete lists of categories
                        },
                        child: Row(
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var doc = snapshot.data!.docs[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 90,
                            height: 80,
                            child: Column(
                              children: [
                                Image.network(doc['image']),
                                Flexible(
                                  child: Text(
                                    doc['catName'],
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  doc(String s) {}

//   get() {}
}
