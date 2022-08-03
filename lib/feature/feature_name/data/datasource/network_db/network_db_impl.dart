import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_shop/feature/feature_name/data/datasource/network_db/network_db.dart';
import 'package:evira_shop/feature/feature_name/data/models/carousel_model.dart';
import 'package:evira_shop/feature/feature_name/data/models/product_model.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/product_entity.dart';
import 'package:evira_shop/feature/feature_name/domain/entities/carousel_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;

class NetworkDbImpl implements NetworkDb {
  late UserCredential authresult;
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

  @override
  Future<void> createUser(
      Map<String, String> usercredentials, BuildContext context) async {
    try {
      authresult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usercredentials['email'].toString(),
          password: usercredentials['password'].toString());
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message!),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> createUserProfile(Map<String, String> usercredentials,
      BuildContext context, File image) async {
    try {
      final ref = await FirebaseStorage.instance
          .ref()
          .child('user-images')
          .child(authresult.user!.uid + '.jpeg');
      ref.putFile(image).whenComplete(() => null);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authresult.user!.uid)
          .set({
        'fullname': usercredentials['fullname'],
        'nickname': usercredentials['nickname'],
        'DOB': usercredentials['date'],
        'email': usercredentials['email'],
        'gender': usercredentials['gender']
      }).then((value) => print('Success'));
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message!),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> addtoCart(Map<String, String> cartProductData) async {
    await FirebaseFirestore.instance
        .collection('cart_orders')
        .doc(authresult.user!.email)
        .set({
      'title': cartProductData['title'],
      'price': cartProductData['price'],
      'product_img_url': cartProductData['product_img_url']
    });
  }
}
