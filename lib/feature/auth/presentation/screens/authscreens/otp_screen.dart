import 'package:flutter/material.dart';
import '../../../../../core/asset_constants.dart' as asset;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_cubit.dart';
import '../../widgets/back_app_bar.dart';
import 'create_profile_screen.dart';

class OtpScreen extends StatelessWidget {
  final FocusNode _focusNodeone = FocusNode();
  final FocusNode _focusNodetwo = FocusNode();
  final FocusNode _focusNodethree = FocusNode();
  final FocusNode _focusNodefour = FocusNode();
  final FocusNode _focusNodefive = FocusNode();
  final FocusNode _focusNodesix = FocusNode();
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, "Otp Verification"),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, CreateProfileScreen.routename, (route) => false);
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .12,
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style: asset.introStyles(20),
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodeone,
                        cursorColor: Colors.black,
                        onChanged: (v) {
                          _focusNodetwo.requestFocus();
                          otp = otp + v;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .12,
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style: asset.introStyles(20),
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodetwo,
                        cursorColor: Colors.black,
                        onChanged: (v) {
                          _focusNodethree.requestFocus();
                          otp = otp + v;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .12,
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style: asset.introStyles(20),
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodethree,
                        cursorColor: Colors.black,
                        onChanged: (v) {
                          _focusNodefour.requestFocus();
                          otp = otp + v;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .12,
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style: asset.introStyles(20),
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodefour,
                        cursorColor: Colors.black,
                        onChanged: (v) {
                          _focusNodefive.requestFocus();
                          otp = otp + v;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .12,
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style: asset.introStyles(20),
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodefive,
                        cursorColor: Colors.black,
                        onChanged: (v) {
                          _focusNodesix.requestFocus();
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .12,
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        style: asset.introStyles(20),
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodesix,
                        cursorColor: Colors.black,
                        onChanged: (v) {},
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )))),
                  ),
                ],
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
              print(otp);
              BlocProvider.of<AuthCubit>(context).authverifyOTP(int.parse(otp));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(35)),
              child: const Text(
                "Verify OTP",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Ubuntu', fontSize: 26),
              ),
            ),
          )),
    );
  }
}
