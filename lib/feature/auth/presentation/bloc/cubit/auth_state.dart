part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthFailure extends AuthState {
  String error;
  AuthFailure({required this.error});
  @override
  List<Object> get props => [error];
}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}
