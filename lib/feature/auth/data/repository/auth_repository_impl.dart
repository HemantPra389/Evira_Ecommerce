import 'dart:io';
import 'package:flutter/src/widgets/framework.dart';

import '../../domain/entities/user_credentail_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/networkdb/auth_network_db.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthNetworkDB authnetworkDB;
  AuthRepositoryImpl({required this.authnetworkDB});
  @override
  Future<String> createUser(
      UserCredentialEntity userCredentialEntity, BuildContext context) async {
    return await authnetworkDB.createUser(userCredentialEntity, context);
  }

  @override
  Future<String> createUserProfile(Map<String, String> usercredentials,
      BuildContext context, File image) async {
    return await authnetworkDB.createUserProfile(
        usercredentials, context, image);
  }

  @override
  Future<String> loginUser(
      UserCredentialEntity userCredentialEntity, BuildContext context) async {
    return await authnetworkDB.loginUser(userCredentialEntity, context);
  }

  @override
  Future<String> authsendOTP(String phoneNumber) async {
    return await authnetworkDB.authsendOTP(phoneNumber);
  }

  @override
  Future<String> authverifyOTP(int otp) async {
    return await authnetworkDB.authverifyOTP(otp);
  }

  @override
  Future<String> forgotpassword(String email) async {
    return await authnetworkDB.forgotpassword(email);
  }
}
