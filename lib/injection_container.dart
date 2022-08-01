import 'package:evira_shop/feature/feature_name/data/datasource/network_db/network_db.dart';
import 'package:evira_shop/feature/feature_name/data/datasource/network_db/network_db_impl.dart';
import 'package:evira_shop/feature/feature_name/data/repositories/repository_impl.dart';
import 'package:evira_shop/feature/feature_name/domain/repositories/repository.dart';
import 'package:evira_shop/feature/feature_name/domain/usecases/getCarouselData_usecase.dart';
import 'package:evira_shop/feature/feature_name/domain/usecases/getProductData_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setup() async {
  //usecase
  locator.registerLazySingleton<GetProductDataUseCase>(
      () => GetProductDataUseCase(respository: locator()));
  locator.registerLazySingleton<GetCarouselDataUseCase>(
      () => GetCarouselDataUseCase(respository: locator()));

  //Repostory
  locator.registerLazySingleton<Repository>(
      () => RepositoryImpl(networkDb: locator()));

  //Network DB
  locator.registerLazySingleton<NetworkDb>(() => NetworkDbImpl());
}
