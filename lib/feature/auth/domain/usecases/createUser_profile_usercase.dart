import 'dart:io';
import 'package:evira_shop/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class CreateUserProfileUseCase {
  final AuthRepository repository;
  CreateUserProfileUseCase({required this.repository});
  Future<String> createUserProfileUseCase(Map<String, String> usercredentials,
      BuildContext context, File image) async {
    return await repository.createUserProfile(usercredentials, context, image);
  }
}
