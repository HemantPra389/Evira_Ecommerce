

import 'package:evira_shop/feature/product/domain/product_domain/entities/product_entity.dart';
import 'package:evira_shop/feature/product/domain/product_domain/repositories/product_repository.dart';

class GetProductDataUseCase {
  final ProductRepository repository;
  GetProductDataUseCase({required this.repository});

  Future<List<ProductEntity>> getProductData(String filename) async {
    return repository.getProductData(filename);
  }
}
