import 'package:craftybay_ecommerce/navigation/main_navigation_screen.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});
  static const String name = '/wishlist-screen';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context, MainNavigationScreen.name);
        }, icon: Icon(Icons.arrow_back)),
          title: Text('Wish List')),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        itemCount: 25,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 4 columns per row
          mainAxisSpacing: 30, // Vertical spacing between rows
          crossAxisSpacing: 12, // Horizontal spacing between columns
          childAspectRatio:
              0.52, // Adjusts height-to-width ratio of each grid cell
        ),
        itemBuilder: (context, index) {
          return Column();
        },
      ),
    );
  }
}
