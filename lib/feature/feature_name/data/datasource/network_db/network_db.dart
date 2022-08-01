import 'package:evira_shop/feature/feature_name/domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/product_entity.dart';

abstract class NetworkDb{
  Future<List<ProductEntity>> getProductData(String filename);
  Future<List<CarouselEntity>> getCarouselData();
}