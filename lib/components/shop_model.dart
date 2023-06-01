import 'package:flutter/material.dart';
import '../pages/customer/shop_menu.dart';

class ShopModel extends StatelessWidget {
  final String shopName;
  final String email;
  final String imageUrl;

  const ShopModel(
      {Key? key,
      required this.shopName,
      required this.email,
      required this.imageUrl})
      : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     height: 150,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => MenuPage(email: email),
  //                 ));
  //             // Go to the shop page
  //           },
  //           child: Container(
  //             height: 160,
  //             width: double.infinity,
  //             child: AspectRatio(
  //               aspectRatio: 1.0,
  //               child: imageUrl != null
  //                   ? Image.network(
  //                       imageUrl,
  //                       fit: BoxFit.cover,
  //                     )
  //                   : Placeholder(),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //           child: Text(
  //             shopName,
  //             style: const TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //               fontSize: 16,
  //             ),
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuPage(email: email),
                  ));
            },
      child: Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              shopName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
