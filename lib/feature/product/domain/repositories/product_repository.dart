import 'dart:io';

import '../entities/carousel_entity.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProductData(String filename);
  Future<List<CarouselEntity>> getCarouselData();

  Future<void> addtoCart(Map<String, String> cartProductData);
  Future<void> deleteCartItem(String id);
  Future<void> orderProduct();
}
