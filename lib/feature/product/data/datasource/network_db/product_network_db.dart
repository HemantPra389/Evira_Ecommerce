

import '../../../domain/entities/carousel_entity.dart';
import '../../../domain/entities/product_entity.dart';

abstract class ProductNetworkDb{
  Future<List<ProductEntity>> getProductData(String filename);
  Future<List<CarouselEntity>> getCarouselData();
  Future<void> addtoCart(Map<String,String> cartProductData);
  Future<void> deleteCartItem(String id);
  Future<void> orderProduct();
  
}