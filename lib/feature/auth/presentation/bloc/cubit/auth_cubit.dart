import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evira_shop/feature/auth/domain/entities/user_credentail_entity.dart';
import 'package:evira_shop/feature/auth/domain/usecases/createUser_profile_usercase.dart';
import 'package:evira_shop/feature/auth/domain/usecases/create_user_usecase.dart';
import 'package:evira_shop/feature/auth/domain/usecases/login_user_usecase.dart';
import 'package:evira_shop/injection_container.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> createUser(
      UserCredentialEntity userCredentialEntity, BuildContext context) async {
    emit(AuthLoading());
    var authState = await locator
        .call<CreateUserUsecase>()
        .createuserUsecase(userCredentialEntity, context);
    if (authState.toString() == "Success") {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure(error: authState.toString()));
    }
  }

  Future<void> createProfile(Map<String, String> usercredentials,
      BuildContext context, File image) async {
    emit(AuthLoading());
    var authstate = await locator
        .call<CreateUserProfileUseCase>()
        .createUserProfileUseCase(usercredentials, context, image);

    if (authstate.toString() == "Success") {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure(error: authstate.toString()));
    }
  }

  Future<void> loginUser(
      UserCredentialEntity userCredentialEntity, BuildContext context) async {
    emit(AuthLoading());
    var authstate = await locator
        .call<LoginUserUseCase>()
        .loginuserusecase(userCredentialEntity, context);
    if (authstate.toString() == "Success") {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure(error: authstate.toString()));
    }
  }
}
