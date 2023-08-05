import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_credentail_entity.dart';
import '../bloc/auth_cubit.dart';

class LoginButton extends StatelessWidget {
  String title;
  UserCredentialEntity userCredentialEntity;
  LoginButton({required this.title, required this.userCredentialEntity});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AuthCubit>(context)
            .loginUser(userCredentialEntity, context);
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
              color: Colors.white, fontFamily: 'Ubuntu', fontSize: 26),
        ),
      ),
    );
  }
}
