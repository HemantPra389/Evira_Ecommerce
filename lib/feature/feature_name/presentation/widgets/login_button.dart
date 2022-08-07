import 'package:evira_shop/feature/feature_name/presentation/bloc/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  String title;
  Map<String, String> usercredentials;
  BuildContext context;
  LoginButton(this.title, this.usercredentials, this.context);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AuthCubit>(context)
            .createUser(usercredentials, context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(35)),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Ubuntu', fontSize: 24),
        ),
      ),
    );
  }
}
