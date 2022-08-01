import 'package:evira_shop/feature/feature_name/presentation/widgets/back_app_bar.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/input_field.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

class SignUpScreen extends StatefulWidget {
  static const routename = '/signup-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(''),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              isLogin ? "Login to your Account" : 'Create Your Account',
              style: asset.introStyles(55),
            ),
            InputField('Email', Icon(Icons.email)),
            InputField('Password',Icon( Icons.lock), Icon(Icons.remove_red_eye), true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.check_outlined,
                    color: Colors.white,
                    size: 27,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Remember me',
                  style: asset.introStyles(16),
                ),
              ],
            ),
            LoginButton(isLogin ? "Sign In" : 'Sign up'),
            if (isLogin == true)
              Text(
                'Forgot the password?',
                style: asset.introStyles(18),
              ),
            Text(
              'or continue with',
              style: asset.introStyles(18, color: Colors.black54),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  asset.facebook_logo,
                  width: 35,
                ),
                Image.asset(
                  asset.google_logo,
                  width: 35,
                ),
                Image.asset(
                  asset.apple_logo,
                  width: 35,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin ? "Don't have account?" : "Already have account?",
                  style: asset.introStyles(16, color: Colors.black54),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(
                    isLogin ? "Sign in" : "Sign up",
                    style: asset.introStyles(16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
