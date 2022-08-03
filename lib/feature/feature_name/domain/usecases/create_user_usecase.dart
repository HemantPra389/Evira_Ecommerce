import 'package:evira_shop/feature/feature_name/domain/repositories/repository.dart';
import 'package:flutter/material.dart';

class CreateUserUsecase {
  final Repository repository;
  CreateUserUsecase({required this.repository});
  Future<void> createuserUsecase(Map<String, String> usercredentials,BuildContext context) async {
    return repository.createUser(usercredentials,context);
  }
}
