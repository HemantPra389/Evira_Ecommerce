import 'package:evira_shop/feature/auth/domain/entities/user_credentail_entity.dart';
import 'package:evira_shop/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class CreateUserUsecase {
  final AuthRepository repository;
  CreateUserUsecase({required this.repository});
  Future<String> createuserUsecase(UserCredentialEntity userCredentialEntity,BuildContext context) async {
    return repository.createUser(userCredentialEntity,context);
  }
}
