import 'package:evira_shop/feature/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:evira_shop/feature/auth/presentation/screens/auth_screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;
import 'package:evira_shop/feature/auth/presentation/widgets/back_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phonecontroller = TextEditingController();
    return Scaffold(
      appBar: BackAppBar(context, "Continue with Phone"),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthCodeSentState) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => AuthCubit(),
                        child: OtpScreen(),
                      )));
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error,style: asset.introStyles(16),),
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
                margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  children: [
                    Image.asset(asset.otp),
                    TextField(
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.number,
                      style: asset.introStyles(24),
                      controller: phonecontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: IconTheme(
                            data:const IconThemeData(color: Colors.grey, size: 25),
                            child: Padding(
                              padding:const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 15),
                              child: Text(
                                '(+91)',
                                style: asset.introStyles(22),
                              ),
                            ),
                          ),
                          hintText: "Enter your phone Number",
                          hintStyle:
                              asset.introStyles(18, color: Colors.black45),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5)),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
          height: 70,
          child: InkWell(
            onTap: () async {
              BlocProvider.of<AuthCubit>(context)
                  .authsendOTP("+91" + phonecontroller.text);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(35)),
              child: const Text(
                "Continue",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Ubuntu', fontSize: 26),
              ),
            ),
          )),
    );
  }
}
