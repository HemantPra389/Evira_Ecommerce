import '../../../../../core/asset_constants.dart' as asset;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product/presentation/screens/home/main_home_screen.dart';
import '../../../../domain/entities/user_credentail_entity.dart';
import '../../bloc/auth_cubit.dart';
import '../../widgets/back_app_bar.dart';
import '../../widgets/login_button.dart';
import 'create_profile_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routename = 'login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserCredentialEntity userCredentialEntity =
      UserCredentialEntity(email: "", password: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BackAppBar(context, ""),
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
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
      }, builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black87,
              strokeWidth: 7,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Login to your account',
                  style: asset.introStyles(55),
                ),
                TextFormField(
                  style: asset.introStyles(20),
                  onChanged: (value) {
                    setState(() {
                      userCredentialEntity.email = value;
                    });
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
                          borderSide: const BorderSide(
                              color: Colors.black, width: 1.5)),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20))),
                ),
                TextFormField(
                  style: asset.introStyles(20),
                  obscureText: true,
                  onChanged: (value) {
                    userCredentialEntity.password = value;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: const IconTheme(
                        data: IconThemeData(color: Colors.grey, size: 25),
                        child: Icon(Icons.email),
                      ),
                      hintText: "Password",
                      prefixIconColor: Colors.grey,
                      hintStyle: asset.introStyles(18, color: Colors.black45),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 1.5)),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20))),
                ),
                LoginButton(
                  title: "Sign In",
                  userCredentialEntity: userCredentialEntity,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AuthCubit(),
                      child: ForgotPasswordScreen(),
                    ),
                  )),
                  child: Text(
                    'Forgot the password?',
                    style: asset.introStyles(20),
                  ),
                ),
                Text(
                  'or continue with',
                  style: asset.introStyles(20, color: Colors.black54),
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
                    Icon(Icons.phone, size: 32)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: asset.introStyles(18, color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Sign up",
                        style: asset.introStyles(18),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
