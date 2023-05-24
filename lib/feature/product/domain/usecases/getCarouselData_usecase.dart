

import '../entities/carousel_entity.dart';
import '../repositories/product_repository.dart';

class GetCarouselDataUseCase {
  final ProductRepository repository;
  GetCarouselDataUseCase({required this.repository});

  Future<List<CarouselEntity>> getCarouselData() async {
    return repository.getCarouselData();
  }
}
