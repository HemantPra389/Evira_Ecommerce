import 'package:evira_shop/feature/feature_name/domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/product_entity.dart';

abstract class Repository {
  Future<List<ProductEntity>> getProductData(String filename);
  Future<List<CarouselEntity>> getCarouselData();
}
