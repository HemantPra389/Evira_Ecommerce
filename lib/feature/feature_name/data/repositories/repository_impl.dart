import 'package:evira_shop/feature/feature_name/data/datasource/network_db/network_db.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/product_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/repositories/repository.dart';
import 'package:flutter/material.dart';

class RepositoryImpl implements Repository {
  final NetworkDb networkDb;
  RepositoryImpl({required this.networkDb});
  @override
  Future<List<ProductEntity>> getProductData(String filename) async {
    return networkDb.getProductData(filename);
  }

  @override
  Future<List<CarouselEntity>> getCarouselData() async {
    return networkDb.getCarouselData();
  }

  @override
  Future<void> createUser(Map<String, String> usercredentials,BuildContext context) async {
    return networkDb.createUser(usercredentials,context);
  }
}
