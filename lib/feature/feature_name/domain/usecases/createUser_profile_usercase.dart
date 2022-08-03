import 'dart:io';

import 'package:evira_shop/feature/feature_name/domain/repositories/repository.dart';
import 'package:flutter/material.dart';

class CreateUserProfileUseCase {
  final Repository repository;
  CreateUserProfileUseCase({required this.repository});
  Future<void> createUserProfileUseCase(Map<String, String> usercredentials,
      BuildContext context, File image) async {
    return repository.createUserProfile(usercredentials, context, image);
  }
}
