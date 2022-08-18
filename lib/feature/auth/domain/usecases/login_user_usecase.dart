import 'package:evira_shop/feature/auth/domain/entities/user_credentail_entity.dart';
import 'package:evira_shop/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginUserUseCase {
  final AuthRepository repository;
  LoginUserUseCase({required this.repository});
  Future<String> loginuserusecase(
      UserCredentialEntity userCredentialEntity, BuildContext context) async {
    return await repository.loginUser(userCredentialEntity, context);
  }
}
