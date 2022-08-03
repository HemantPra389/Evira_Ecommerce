import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evira_shop/feature/feature_name/domain/usecases/createUser_profile_usercase.dart';
import 'package:evira_shop/feature/feature_name/domain/usecases/create_user_usecase.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/auth/auth_screens/create_profile_screen.dart';
import 'package:evira_shop/injection_container.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> createUser(
      Map<String, String> usercredentials, BuildContext context) async {
    emit(AuthLoading());
    await locator
        .call<CreateUserUsecase>()
        .createuserUsecase(usercredentials, context)
        .then((value) => emit(AuthSuccess()));
  }

  Future<void> createProfile(Map<String, String> usercredentials,
      BuildContext context, File image) async {
    emit(AuthLoading());
    await locator
        .call<CreateUserProfileUseCase>()
        .createUserProfileUseCase(usercredentials, context, image)
        .then((value) => emit(AuthSuccess()));
  }
}
