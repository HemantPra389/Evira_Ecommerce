import 'dart:io';

import 'package:flutter/material.dart';

import '../repository/auth_repository.dart';

class CreateUserProfileUseCase {
  final AuthRepository repository;
  CreateUserProfileUseCase({required this.repository});
  Future<String> createUserProfileUseCase(Map<String, String> usercredentials,
      BuildContext context, File image) async {
    return await repository.createUserProfile(usercredentials, context, image);
  }
}
