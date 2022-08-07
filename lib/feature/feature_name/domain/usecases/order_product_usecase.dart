import 'package:evira_shop/feature/feature_name/domain/repositories/repository.dart';

class OrderProductUseCase {
  final Repository repository;
  OrderProductUseCase({required this.repository});
  Future<void> orderProductUsecase() async {
    await repository.orderProduct();
  }
}
