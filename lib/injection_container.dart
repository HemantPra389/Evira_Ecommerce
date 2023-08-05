import 'package:get_it/get_it.dart';

import 'feature/auth/data/datasource/networkdb/auth_network_db.dart';
import 'feature/auth/data/datasource/networkdb/auth_network_db_impl.dart';
import 'feature/auth/data/repository/auth_repository_impl.dart';
import 'feature/auth/domain/repository/auth_repository.dart';
import 'feature/auth/domain/usecases/auth_sendOTP_usecase.dart';
import 'feature/auth/domain/usecases/auth_verifyOTP_usecase.dart';
import 'feature/auth/domain/usecases/createUser_profile_usercase.dart';
import 'feature/auth/domain/usecases/create_user_usecase.dart';
import 'feature/auth/domain/usecases/forgot_password_usecase.dart';
import 'feature/auth/domain/usecases/login_user_usecase.dart';
import 'feature/product/data/datasource/network_db/product_network_db.dart';
import 'feature/product/data/datasource/network_db/product_network_db_impl.dart';
import 'feature/product/data/repositories/repository_impl.dart';
import 'feature/product/domain/repositories/product_repository.dart';
import 'feature/product/domain/usecases/addto_cart_usecase.dart';
import 'feature/product/domain/usecases/delete_cart_item.dart';
import 'feature/product/domain/usecases/getCarouselData_usecase.dart';
import 'feature/product/domain/usecases/getProductData_usecase.dart';
import 'feature/product/domain/usecases/order_product_usecase.dart';

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
  locator.registerLazySingleton<AuthSendOTPUseCase>(
      () => AuthSendOTPUseCase(authRepository: locator()));
  locator.registerLazySingleton<AuthVerifyOTPUseCase>(
      () => AuthVerifyOTPUseCase(authRepository: locator()));
  locator.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(authRepository: locator()));

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
