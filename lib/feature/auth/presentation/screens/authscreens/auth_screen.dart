import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/asset_constants.dart' as asset;
import '../../../domain/entities/user_credentail_entity.dart';
import '../../../../product/presentation/screens/home/main_home_screen.dart';
import '../../bloc/auth_cubit.dart';
import 'signup_screen%20copy.dart';

class AuthScreen extends StatefulWidget {
  static const routename = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, MainHomeScreen.routename, (route) => false);
            BlocProvider.of<AuthCubit>(context).emit(AuthInitial());
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).errorColor,
            ));
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
            return SafeArea(
                child: SingleChildScrollView(
              child: SingleChildScrollView(
                child: Container(
                  height: mediaQuery.height,
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaQuery.width * .04,
                      vertical: mediaQuery.height * .02),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              asset.splash_login,
                              width: 360,
                            )
                                .animate()
                                .fadeIn(duration: Duration(milliseconds: 1000)),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Login",
                                  style: asset.introStyles(48,
                                      fontWeight: FontWeight.bold),
                                ).animate().fade().shimmer(
                                    duration: Duration(milliseconds: 1000)),
                              ],
                            ),
                            SizedBox(height: mediaQuery.height * .02),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: emailController,
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
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Colors.grey)),
                            ),
                            SizedBox(height: mediaQuery.height * .02),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Colors.grey)),
                            ),
                            SizedBox(height: mediaQuery.height * .02),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: mediaQuery.height * .05,
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<AuthCubit>(context).loginUser(
                                    UserCredentialEntity(
                                        email: emailController.text,
                                        password: passwordController.text),
                                    context);
                              },
                              child: Container(
                                width: double.infinity,
                                height: mediaQuery.height * .07,
                                decoration: BoxDecoration(
                                    color: asset.buttoncolour,
                                    borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Login",
                                  style: asset.introStyles(
                                    mediaQuery.height * .024,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ).animate().fade().shimmer(
                                duration: Duration(milliseconds: 1000)),
                            SizedBox(height: mediaQuery.height * .02),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        "By Clicking the Login button,you accept\nthe terms of the ",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontFamily: 'Inter',
                                        fontSize: mediaQuery.height * .014),
                                  ),
                                  TextSpan(
                                    text: "privacy policy",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.black45,
                                        fontFamily: 'Inter',
                                        fontSize: mediaQuery.height * .014),
                                  ),
                                ])),
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'Inter',
                                      fontSize: mediaQuery.height * .014),
                                ),
                                TextSpan(
                                  text: "Sign Up",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => AuthCubit(),
                                          child: SignUpScreen(),
                                        ),
                                      ));
                                    },
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.purple,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: mediaQuery.height * .014),
                                ),
                              ])),
                        ),
                        SizedBox(height: mediaQuery.height * .01),
                      ]),
                ),
              ),
            ));
          }
        },
      ),
    );
  }
}
