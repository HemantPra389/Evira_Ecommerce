import 'package:evira_shop/feature/feature_name/domain/repositories/repository.dart';

class AddtoCartUseCase {
  final Repository repository;
  AddtoCartUseCase({required this.repository});

  Future<void> addtoCartUsecase(Map<String, String> cartProductData) async {
    return repository.addtoCart(cartProductData);
  }
}
