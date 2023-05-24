

import '../repository/auth_repository.dart';

class AuthSendOTPUseCase {
  final AuthRepository authRepository;
  AuthSendOTPUseCase({required this.authRepository});
  Future<String> authSendOTPUseCase(String phoneNumber) async {
    return authRepository.authsendOTP(phoneNumber);
  }
}
