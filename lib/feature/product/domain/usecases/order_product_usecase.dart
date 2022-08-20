import 'package:evira_shop/feature/product/domain/repositories/product_repository.dart';

class OrderProductUseCase {
  final ProductRepository repository;
  OrderProductUseCase({required this.repository});
  Future<void> orderProductUsecase() async {
    await repository.orderProduct();
  }
}
