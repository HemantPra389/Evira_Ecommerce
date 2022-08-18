import 'package:get_it/get_it.dart';

import 'feature/auth/data/datasource/network_db/auth_network_db.dart';
import 'feature/auth/data/datasource/network_db/auth_network_db_impl.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/repositories/auth_repository.dart';
import 'feature/auth/domain/usecases/createUser_profile_usercase.dart';
import 'feature/auth/domain/usecases/create_user_usecase.dart';
import 'feature/auth/domain/usecases/login_user_usecase.dart';
import 'feature/product/data/product_data/datasource/network_db/product_network_db.dart';
import 'feature/product/data/product_data/datasource/network_db/product_network_db_impl.dart';
import 'feature/product/data/product_data/repositories/repository_impl.dart';
import 'feature/product/domain/product_domain/repositories/product_repository.dart';
import 'feature/product/domain/product_domain/usecases/addto_cart_usecase.dart';
import 'feature/product/domain/product_domain/usecases/delete_cart_item.dart';
import 'feature/product/domain/product_domain/usecases/getCarouselData_usecase.dart';
import 'feature/product/domain/product_domain/usecases/getProductData_usecase.dart';
import 'feature/product/domain/product_domain/usecases/order_product_usecase.dart';

GetIt locator = GetIt.instance;

Future<void> setup() async {
  //usecase

  //usecase-auth
  locator.registerLazySingleton<CreateUserUsecase>(
      () => CreateUserUsecase(repository: locator()));
  locator.registerLazySingleton<CreateUserProfileUseCase>(
      () => CreateUserProfileUseCase(repository: locator()));
  locator.registerLazySingleton<LoginUserUseCase>(
      () => LoginUserUseCase(repository: locator()));

  //usecase-product
  locator.registerLazySingleton<GetProductDataUseCase>(
      () => GetProductDataUseCase(repository: locator()));
  locator.registerLazySingleton<GetCarouselDataUseCase>(
      () => GetCarouselDataUseCase(repository: locator()));
  locator.registerLazySingleton<AddtoCartUseCase>(
      () => AddtoCartUseCase(repository: locator()));
  locator.registerLazySingleton<OrderProductUseCase>(
      () => OrderProductUseCase(repository: locator()));
  locator.registerLazySingleton<DeleteCartItemUseCase>(
      () => DeleteCartItemUseCase(repository: locator()));

  //Repostory
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authnetworkDB: locator()));
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productNetworkDb: locator()));

  //Network DB
  locator.registerLazySingleton<AuthNetworkDB>(() => AuthNetworkDBImpl());
  locator.registerLazySingleton<ProductNetworkDb>(() => ProductNetworkDbImpl());
}
