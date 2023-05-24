import '../repository/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository authRepository;
  ForgotPasswordUseCase({required this.authRepository});
  Future<String> forgotpasswordusecase(String email) async {
    return await authRepository.forgotpassword(email);
  }
}
