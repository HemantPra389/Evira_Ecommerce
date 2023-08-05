import 'dart:io';
import 'package:flutter/material.dart';

import '../../../domain/entities/user_credentail_entity.dart';

abstract class AuthNetworkDB {
  Future<String> createUser(
      UserCredentialEntity userCredentialEntity, BuildContext context);
  Future<String> loginUser(
      UserCredentialEntity userCredentialEntity, BuildContext context);
  Future<String> createUserProfile(
      Map<String, String> usercredentials, BuildContext context, File image);
  Future<String> forgotpassword(String email);
  Future<String> authsendOTP(String phoneNumber);
  Future<String> authverifyOTP(int otp);
}
