

import 'package:evira_shop/feature/product/domain/product_domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/product/domain/product_domain/repositories/product_repository.dart';

class GetCarouselDataUseCase {
  final ProductRepository repository;
  GetCarouselDataUseCase({required this.repository});

  Future<List<CarouselEntity>> getCarouselData() async {
    return repository.getCarouselData();
  }
}
