import 'package:evira_shop/feature/feature_name/presentation/screens/home/cart/cart_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/home/home/home_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/home/order/order_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/home/profile/profile_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/home/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

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
    WalletScreen(),
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
        selectedItemColor: Colors.black,
        currentIndex: currentIndex,
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
                asset.wallet,
                color: currentIndex == 3 ? Colors.black87 : Colors.black54,
                width: 25,
              ),
              label: "Wallet"),
          BottomNavigationBarItem(
              icon: Image.asset(
                asset.profile,
                color: currentIndex == 4 ? Colors.black87 : Colors.black54,
                width: 25,
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
