import 'dart:io';

import 'package:evira_shop/feature/feature_name/domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

abstract class Repository {
  Future<List<ProductEntity>> getProductData(String filename);
  Future<List<CarouselEntity>> getCarouselData();
  Future<void> createUser(
      Map<String, String> usercredentials, BuildContext context);
  Future<void> createUserProfile(
      Map<String, String> usercredentials, BuildContext context, File image);
  Future<void> addtoCart(Map<String,String> cartProductData);
}
