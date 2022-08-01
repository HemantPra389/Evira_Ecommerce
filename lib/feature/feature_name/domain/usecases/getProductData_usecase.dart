import 'package:evira_shop/feature/feature_name/domain/entities/product_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/repositories/repository.dart';

class GetProductDataUseCase {
  final Repository respository;
  GetProductDataUseCase({required this.respository});

  Future<List<ProductEntity>> getProductData(String filename) async{
    return respository.getProductData(filename);
  }
}
