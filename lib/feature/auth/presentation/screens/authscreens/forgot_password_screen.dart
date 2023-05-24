import '../../../../../core/asset_constants.dart' as asset;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_cubit.dart';
import '../../widgets/back_app_bar.dart';


class ForgotPasswordScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, "Forgot Password"),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Email Sent Successfully"),
              backgroundColor: Colors.green,
            ));
            Navigator.of(context).pop();
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
            return Column(
              children: [
                Image.asset(asset.otp),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextField(
                    style: asset.introStyles(24),
                    controller: email,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Enter your email address",
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
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
          height: 70,
          child: InkWell(
            onTap: () async {
              BlocProvider.of<AuthCubit>(context).resetPassword(email.text);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(35)),
              child: const Text(
                "Reset Password",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Ubuntu', fontSize: 26),
              ),
            ),
          )),
    );
  }
}
