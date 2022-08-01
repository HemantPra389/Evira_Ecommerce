import 'package:evira_shop/feature/feature_name/domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/repositories/repository.dart';

class GetCarouselDataUseCase {
  final Repository respository;
  GetCarouselDataUseCase({required this.respository});

  Future<List<CarouselEntity>> getCarouselData() async{
    return respository.getCarouselData();
  }
}
