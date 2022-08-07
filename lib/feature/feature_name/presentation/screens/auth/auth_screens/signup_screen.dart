import 'package:evira_shop/feature/feature_name/presentation/bloc/cubit/auth/auth_cubit.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/auth/auth_screens/create_profile_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/back_app_bar.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static const routename = '/signup-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLogin = false;
  @override
  Map<String, String> userData_signup = {
    'email': '',
    "username": '',
    'password': ''
  };

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BackAppBar(context,''),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, CreateProfileScreen.routename, (route) => false);
            BlocProvider.of<AuthCubit>(context).emit(AuthInitial());
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
                strokeWidth: 7,
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    isLogin ? "Login to your Account" : 'Create Your Account',
                    style: asset.introStyles(55),
                  ),
                  TextFormField(
                    style: asset.introStyles(20),
                    obscureText: false,
                    onChanged: (value) {
                      setState(() {
                        userData_signup['email'] = value;
                      });
                    },
                    validator: (value) {
                      String pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = RegExp(pattern);
                      if (value == null ||
                          value.isEmpty ||
                          !regex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: const IconTheme(
                          data: IconThemeData(color: Colors.grey, size: 25),
                          child: Icon(Icons.email),
                        ),
                        hintText: "Email",
                        prefixIconColor: Colors.grey,
                        hintStyle: asset.introStyles(18, color: Colors.black45),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1.5)),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  if (isLogin == false)
                    TextFormField(
                      style: asset.introStyles(20),
                      obscureText: false,
                      onChanged: (value) {
                        userData_signup['username'] = value;
                      },
                      validator: (value) {},
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.grey, size: 25),
                            child:  Icon(Icons.person_add_alt),
                          ),
                          hintText: "Username",
                          prefixIconColor: Colors.grey,
                          hintStyle:
                              asset.introStyles(18, color: Colors.black45),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.black, width: 1.5)),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  TextFormField(
                    style: asset.introStyles(20),
                    obscureText: true,
                    onChanged: (value) {
                      userData_signup['password'] = value;
                    },
                    validator: (value) {},
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.grey, size: 25),
                            child:  Icon(Icons.lock_outline)),
                        hintText: "Password",
                        suffixIcon: const IconTheme(
                          child:  Icon(Icons.remove_red_eye),
                          data:  IconThemeData(color: Colors.grey),
                        ),
                        prefixIconColor: Colors.grey,
                        hintStyle: asset.introStyles(18, color: Colors.black45),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1.5)),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        child: const Icon(
                          Icons.check_outlined,
                          color: Colors.white,
                          size: 27,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Remember me',
                        style: asset.introStyles(16),
                      ),
                    ],
                  ),
                  LoginButton(isLogin ? "Sign In" : 'Sign up', userData_signup,
                      context),
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
                        isLogin
                            ? "Don't have account?"
                            : "Already have account?",
                        style: asset.introStyles(16, color: Colors.black54),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLogin = !isLogin;
                            userData_signup = {
                              'email': '',
                              "username": '',
                              'password': ''
                            };
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
            );
          }
        },
      ),
    );
  }
}
