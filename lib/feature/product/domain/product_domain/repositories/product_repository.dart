import 'dart:io';

import 'package:evira_shop/feature/product/domain/product_domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/product/domain/product_domain/entities/product_entity.dart';


abstract class ProductRepository {
  Future<List<ProductEntity>> getProductData(String filename);
  Future<List<CarouselEntity>> getCarouselData();
  
  Future<void> addtoCart(Map<String, String> cartProductData);
  Future<void> deleteCartItem(String id);
  Future<void> orderProduct();
}
