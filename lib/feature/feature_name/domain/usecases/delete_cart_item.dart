import 'package:evira_shop/feature/feature_name/domain/repositories/repository.dart';

class DeleteCartItemUseCase {
  final Repository repository;
  DeleteCartItemUseCase({required this.repository});
  Future<void> delete_cart_item_usecase(String id) async {
    await repository.deleteCartItem(id);
  }
}
