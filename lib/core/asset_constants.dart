import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const logo1 = "assets/icons/logo/logo1.png";
const logo2 = "assets/icons/logo/logo2.png";
const loading = "assets/icons/logo/logo_loading.png";
const splash_login = "assets/images/illustrations/splash_screen1.png";
const splash_store = "assets/images/illustrations/splash_screen2.png";
const splash_drop = "assets/images/illustrations/splash_screen3.png";
const splash_check = "assets/images/illustrations/splash_screen4.png";
const otp = "assets/images/illustrations/otp.png";
const apple_logo = "assets/icons/general/social/apple.png";
const facebook_logo = "assets/icons/general/social/facebook.png";
const paypal = "assets/icons/general/social/paypal.png";
const google_logo = "assets/icons/general/social/google.png";
const notification_bell = "assets/icons/general/home/notificationbell.png";
const heart = "assets/icons/general/home/heart.png";
const filter = "assets/icons/general/home/filter.png";
const search = "assets/icons/general/home/search.png";
const empty_cart_error = "assets/icons/general/home/emptycart.png";
const no_transaction = "assets/icons/general/home/no_transaction.png";
const home = "assets/icons/general/bottom_nav/home.png";
const cart = "assets/icons/general/bottom_nav/cart.png";
const orders = "assets/icons/general/bottom_nav/orders.png";
const wallet = "assets/icons/general/bottom_nav/wallet.png";
const profile = "assets/icons/general/bottom_nav/profile.png";

String numberFormat(int price) {
  final numberFormatter = NumberFormat(
    "##,##,###",
    "en_US", // local US
  );

  return numberFormatter.format(price);
}

String timeConversion(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
}

TextStyle introStyles(double size, {Color color = Colors.black87}) {
  return TextStyle(fontFamily: 'Ubuntu', color: color, fontSize: size);
}

Container category_chip(String title, String activeChiptitle) {
  if (title.toLowerCase() != activeChiptitle) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      child: Chip(
        label: Text(
          title,
          style: introStyles(16),
        ),
        backgroundColor: Colors.white,
        side: const BorderSide(
          width: 1.5,
        ),
      ),
    );
  } else {
    return Container(
      child: Chip(
        label: Text(
          title,
          style: introStyles(16, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        side: const BorderSide(
          width: 1.5,
        ),
      ),
    );
  }
}
