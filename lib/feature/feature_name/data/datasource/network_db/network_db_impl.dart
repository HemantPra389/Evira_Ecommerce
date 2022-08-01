import 'dart:convert';

import 'package:evira_shop/feature/feature_name/data/datasource/network_db/network_db.dart';
import 'package:evira_shop/feature/feature_name/data/models/carousel_model.dart';
import 'package:evira_shop/feature/feature_name/data/models/product_model.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/product_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/carousel_entity.dart';

import 'package:flutter/services.dart' show rootBundle;

class NetworkDbImpl implements NetworkDb {
  @override
  Future<List<ProductEntity>> getProductData(String filename) async {
    List<ProductModel>? productList;
    await rootBundle.loadString('assets/json/$filename.json').then((value) {
      List<dynamic> decodedData = json.decode(value);
      productList = decodedData.map((e) => ProductModel.fromJson(e)).toList();
    });

    return productList!;
  }

  @override
  Future<List<CarouselEntity>> getCarouselData() async {
    List<CarouselEntity>? carouselList;
    await rootBundle.loadString('assets/json/carousel.json').then((value) {
      List<dynamic> decodedData = json.decode(value);
      carouselList = decodedData.map((e) => CarouselModel.fromJson(e)).toList();
    });
    return carouselList!;
  }
}
