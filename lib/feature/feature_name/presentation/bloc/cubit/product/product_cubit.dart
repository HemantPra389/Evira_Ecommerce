import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/product_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/usecases/getCarouselData_usecase.dart';
import 'package:evira_shop/feature/feature_name/domain/usecases/getProductData_usecase.dart';
import 'package:evira_shop/injection_container.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  Future<List<ProductEntity>> getProductData(String filename) async {
    return await locator.call<GetProductDataUseCase>().getProductData(filename);
  }

  Future<List<CarouselEntity>> getCarouselData() async {
    return await locator.call<GetCarouselDataUseCase>().getCarouselData();
  }
}
