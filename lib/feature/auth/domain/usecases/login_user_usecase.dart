import 'package:flutter/material.dart';

import '../entities/user_credentail_entity.dart';
import '../repository/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;
  LoginUserUseCase({required this.repository});
  Future<String> loginuserusecase(
      UserCredentialEntity userCredentialEntity, BuildContext context) async {
    return await repository.loginUser(userCredentialEntity, context);
  }
}
