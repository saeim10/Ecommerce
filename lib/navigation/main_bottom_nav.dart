import 'package:craftybay_ecommerce/app/localization/localization_extension.dart';
import 'package:flutter/material.dart';

class MainBottomNav extends StatefulWidget {
   final int currentIndex;
   final Function(int) onTap;

  const MainBottomNav({
    super.key,
     required this.currentIndex,
     required this.onTap,
  });
  static const String name = '/bottom-nav';

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: context.localization.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_outlined),
          activeIcon: Icon(Icons.grid_view),
          label: context.localization.categories,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket_outlined),
          activeIcon: Icon(Icons.shopping_basket),
          label: context.localization.cart,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard_outlined),
          activeIcon: Icon(Icons.card_giftcard),
          label: context.localization.wish,
        ),
      ],
    );
  }
}