import 'package:evira_shop/feature/feature_name/presentation/screens/home/home/home_screen.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  String title;
  LoginButton(this.title);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routename, (route) => false);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(35)),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontFamily: 'Ubuntu', fontSize: 24),
        ),
      ),
    );
  }
}
