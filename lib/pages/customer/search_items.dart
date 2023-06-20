import 'package:flutter/material.dart';

class RestaurantSearchPage extends StatefulWidget {
  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search for a restaurant',
              ),
              onChanged: (text) {
                // Perform search logic here
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 5, // Number of restaurants,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust the number of columns as desired
              ),
              itemBuilder: (BuildContext context, int index) {
                // Build the restaurant item widget based on the index
                return Container(
                    // Restaurant item widget design
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
