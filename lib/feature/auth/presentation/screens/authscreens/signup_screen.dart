import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../../../core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/user_credentail_entity.dart';
import '../../bloc/auth_cubit.dart';
import '../../widgets/back_app_bar.dart';
import '../../widgets/signup_button.dart';
import 'create_profile_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routename = '/signup-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  UserCredentialEntity userCredentialEntity =
      UserCredentialEntity(email: "", password: "");
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BackAppBar(context, ''),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, CreateProfileScreen.routename, (route) => false);
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
            return Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Create Your Account',
                    style: asset.introStyles(55),
                  ),
                  TextFormField(
                    style: asset.introStyles(20),
                    obscureText: false,
                    onChanged: (value) {
                      setState(() {
                        userCredentialEntity.email = value;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    validator: (value) {},
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: const IconTheme(
                            data: IconThemeData(color: Colors.grey, size: 25),
                            child: Icon(Icons.lock_outline)),
                        hintText: "Password",
                        suffixIcon: const IconTheme(
                          child: Icon(Icons.remove_red_eye),
                          data: IconThemeData(color: Colors.grey),
                        ),
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
                  SignUpButton(
                    title: "Sign up",
                    userCredentialEntity: userCredentialEntity,
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
                        "Already have account?",
                        style: asset.introStyles(18, color: Colors.black54),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Sign in",
                          style: asset.introStyles(18),
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
