import 'package:evira_shop/feature/feature_name/presentation/bloc/cubit/auth/auth_cubit.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/auth/auth_screens/create_profile_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/home/cart/cart_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/home/main_home_screen.dart';
import 'package:evira_shop/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/auth/auth_screens/auth_main_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/auth/auth_screens/signup_screen.dart';
import 'package:evira_shop/feature/feature_name/presentation/screens/auth/splash_screen/main_splash_screen.dart';

import 'feature/feature_name/presentation/bloc/cubit/product/product_cubit.dart';
import 'feature/feature_name/presentation/screens/home/home/carousel_list.dart';
import 'feature/feature_name/presentation/screens/home/home/home_screen.dart';
import 'feature/feature_name/presentation/screens/home/home/most_popular_product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setup();
  runApp(MyApp());
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
      routes: {
        '/': (context) => MainSplashScreen(),
        AuthMainScreen.routename: (context) => AuthMainScreen(),
        SignUpScreen.routename: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: SignUpScreen(),
            ),
        CreateProfileScreen.routename: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: CreateProfileScreen(),
            ),
        HomeScreen.routename: (context) => BlocProvider(
              create: (context) => ProductCubit(),
              child: HomeScreen(),
            ),
        CarouselList.routename: (context) => CarouselList(),
        MostPopularProductScreen.routename: (context) => BlocProvider(
              create: (context) => ProductCubit(),
              child: MostPopularProductScreen(),
            ),
        CartScreen.routename: (context) => CartScreen(),
        MainHomeScreen.routename: (context) => MainHomeScreen()
      },
    );
  }
}
