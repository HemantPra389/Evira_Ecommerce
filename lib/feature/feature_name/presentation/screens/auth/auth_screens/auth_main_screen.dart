import 'package:evira_shop/feature/feature_name/presentation/screens/auth/auth_screens/signup_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/home/main_home_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

class AuthMainScreen extends StatelessWidget {
  static const routename = '/authmainscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              asset.splash_login,
              width: 360,
            ),
            Text(
              "Let's you in",
              style: asset.introStyles(50),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  login_button('Continue with facebook', asset.facebook_logo),
                  login_button('Continue with Google', asset.google_logo),
                  login_button('Continue with Apple', asset.apple_logo),
                ],
              ),
            ),
            Text(
              'or',
              style: asset.introStyles(20, color: Colors.black54),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignUpScreen.routename, (route) => false);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(35)),
                child: Text(
                  'Sign in with password',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Ubuntu', fontSize: 24),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account?",
                  style: asset.introStyles(16, color: Colors.black54),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.routename);
                  },
                  child: Text(
                    "Sign up",
                    style: asset.introStyles(16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Row login_button(String title, String iconpath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          iconpath,
          width: 35,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: asset.introStyles(20),
        )
      ],
    );
  }
}
