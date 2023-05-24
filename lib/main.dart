import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/auth/presentation/bloc/auth_cubit.dart';
import 'feature/auth/presentation/screens/authscreens/auth_main_screen.dart';
import 'feature/auth/presentation/screens/authscreens/create_profile_screen.dart';
import 'feature/auth/presentation/screens/authscreens/login_screen.dart';
import 'feature/auth/presentation/screens/authscreens/signup_screen.dart';
import 'feature/auth/presentation/screens/splashscreens/main_splash_screen.dart';
import 'feature/product/presentation/bloc/cubit/product_cubit.dart';
import 'feature/product/presentation/screens/home/cart/cart_screen.dart';
import 'feature/product/presentation/screens/home/home/carousel_list.dart';
import 'feature/product/presentation/screens/home/home/home_screen.dart';
import 'feature/product/presentation/screens/home/home/most_popular_product_screen.dart';
import 'feature/product/presentation/screens/home/main_home_screen.dart';
import 'injection_container.dart';
import 'package:flutter/material.dart';

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
        LoginScreen.routename: ((context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: LoginScreen(),
            )),
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
