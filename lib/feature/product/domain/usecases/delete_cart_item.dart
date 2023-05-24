

import '../repositories/product_repository.dart';

class DeleteCartItemUseCase {
  final ProductRepository repository;
  DeleteCartItemUseCase({required this.repository});
  Future<void> delete_cart_item_usecase(String id) async {
    await repository.deleteCartItem(id);
  }
}
