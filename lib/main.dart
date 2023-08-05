import 'dart:io';

import 'package:evira_ecommerce/feature/auth/presentation/screens/authscreens/auth_screen.dart';
import 'package:evira_ecommerce/feature/auth/presentation/screens/authscreens/create_profile_screen.dart';
import 'package:evira_ecommerce/feature/auth/presentation/screens/authscreens/signup_screen%20copy.dart';
import 'package:evira_ecommerce/feature/product/domain/entities/address_entity.dart';
import 'package:evira_ecommerce/feature/product/domain/entities/cart_product_entity.dart';
import 'package:evira_ecommerce/feature/product/domain/entities/profile_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:evira_ecommerce/core/asset_constants.dart' as asset;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'feature/auth/presentation/bloc/auth_cubit.dart';
import 'feature/auth/presentation/screens/splashscreens/main_splash_screen.dart';
import 'feature/product/presentation/bloc/cubit/product_cubit.dart';
import 'feature/product/presentation/screens/home/cart/cart_screen.dart';
import 'feature/product/presentation/screens/home/home/carousel_list.dart';
import 'feature/product/presentation/screens/home/home/home_screen.dart';
import 'feature/product/presentation/screens/home/home/most_popular_product_screen.dart';
import 'feature/product/presentation/screens/home/main_home_screen.dart';
import 'injection_container.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.initFlutter();
  await Firebase.initializeApp();
  await openhiveBoxes();
  await setup();
  runApp(MyApp());
}

Future<void> openhiveBoxes() async {
  Hive.openBox<CartProductEntity>(asset.hivefavbox);
  Hive.registerAdapter(CartProductEntityAdapter());
  Hive.openBox<ProfileEntity>(asset.hiveprofilebox);
  Hive.registerAdapter(ProfileEntityAdapter());
  Hive.openBox<AddressEntity>(asset.hiveaddressbox);
  Hive.registerAdapter(AddressEntityAdapter());
}

String isAuth() {
  if (FirebaseAuth.instance.currentUser != null) {
    return MainHomeScreen.routename;
  }
  return '/';
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isAuth(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      routes: {
        '/': (context) => MainSplashScreen(),
        AuthScreen.routename: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: AuthScreen(),
            ),
        SignUpScreen.routename: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: SignUpScreen(),
            ),
        CreateProfileScreen.routename: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: CreateProfileScreen(),
            ),
        HomeScreen.routename: (context) => HomeScreen(),
        CarouselList.routename: (context) => CarouselList(),
        MostPopularProductScreen.routename: (context) =>
            MostPopularProductScreen(),
        CartScreen.routename: (context) => CartScreen(),
        MainHomeScreen.routename: (context) => BlocProvider(
              create: (context) => ProductCubit(),
              child: MainHomeScreen(),
            )
      },
    );
  }
}
