
import 'package:evira_shop/feature/product/data/datasource/network_db/product_network_db.dart';
import 'package:evira_shop/feature/product/domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/product/domain/entities/product_entity.dart';
import 'package:evira_shop/feature/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductNetworkDb productNetworkDb;
  ProductRepositoryImpl({required this.productNetworkDb});

  @override
  Future<List<ProductEntity>> getProductData(String filename) async {
    return productNetworkDb.getProductData(filename);
  }

  @override
  Future<List<CarouselEntity>> getCarouselData() async {
    return productNetworkDb.getCarouselData();
  }

  @override
  Future<void> addtoCart(Map<String, String> cartProductData) {
    return productNetworkDb.addtoCart(cartProductData);
  }

  @override
  Future<void> orderProduct() async {
    return productNetworkDb.orderProduct();
  }

  @override
  Future<void> deleteCartItem(String id) async {
    return await productNetworkDb.deleteCartItem(id);
  }
}
