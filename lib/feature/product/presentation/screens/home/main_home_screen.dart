import 'package:flutter/material.dart';
import 'package:evira_ecommerce/core/asset_constants.dart' as asset;

import 'cart/cart_screen.dart';
import 'home/home_screen.dart';
import 'order/order_screen.dart';
import 'profile/profile_screen.dart';

class MainHomeScreen extends StatefulWidget {
  static const routename = '/mainhomescreen';

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    OrderScreen(),
    ProfileScreen()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: asset.introStyles(12),
        selectedItemColor: asset.buttoncolour,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        elevation: 4,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                asset.home,
                color: currentIndex == 0 ? Colors.black87 : Colors.black54,
                width: 25,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                asset.cart,
                color: currentIndex == 1 ? Colors.black87 : Colors.black54,
                width: 25,
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: Image.asset(
                asset.orders,
                color: currentIndex == 2 ? Colors.black87 : Colors.black54,
                width: 25,
              ),
              label: "Orders"),
          BottomNavigationBarItem(
              icon: Image.asset(
                asset.profile,
                color: currentIndex == 3 ? Colors.black87 : Colors.black54,
                width: 25,
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
