import 'package:craftybay_ecommerce/features/carts/presentation/screens/cart_screen.dart';
import 'package:craftybay_ecommerce/features/category/presentation/screens/categories_screen.dart';
import 'package:craftybay_ecommerce/features/home/presentation/screens/home_screen.dart';
import 'package:craftybay_ecommerce/features/wishlist/presentation/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';

import 'main_bottom_nav.dart';
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});
  static const String name = '/main-navigation';

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> pages =  [
    HomeScreen(), //0
    CategoriesScreen(), //1
    CartScreen(), //2
    WishListScreen() //3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],

      bottomNavigationBar: MainBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}