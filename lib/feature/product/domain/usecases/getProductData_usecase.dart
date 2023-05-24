

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductDataUseCase {
  final ProductRepository repository;
  GetProductDataUseCase({required this.repository});

  Future<List<ProductEntity>> getProductData(String filename) async {
    return repository.getProductData(filename);
  }
}
