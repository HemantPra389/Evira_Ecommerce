import 'dart:io';
import 'package:evira_shop/feature/auth/domain/entities/user_credentail_entity.dart';
import 'package:flutter/material.dart';

abstract class AuthNetworkDB{
  Future<String> createUser(
      UserCredentialEntity userCredentialEntity, BuildContext context);
  Future<String> loginUser(
      UserCredentialEntity userCredentialEntity, BuildContext context);
  Future<String> createUserProfile(
      Map<String, String> usercredentials, BuildContext context, File image);
}