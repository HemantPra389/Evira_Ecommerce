import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_shop/feature/auth/domain/entities/user_credentail_entity.dart';
import 'package:evira_shop/feature/product/data/product_data/models/carousel_model.dart';
import 'package:evira_shop/feature/product/data/product_data/models/product_model.dart';
import 'package:evira_shop/feature/product/domain/product_domain/entities/carousel_entity.dart';
import 'package:evira_shop/feature/product/domain/product_domain/entities/product_entity.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;

import 'product_network_db.dart';

class ProductNetworkDbImpl implements ProductNetworkDb {
  int itemnum = 0;
  List<Map<String, dynamic>> newList = [];
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
      UserCredentialEntity userCredentialEntity, BuildContext context) async {
    
  }

  @override
  Future<void> loginUser(UserCredentialEntity userCredentialEntity, BuildContext context) async{
    
  }
  

  @override
  Future<void> createUserProfile(Map<String, String> usercredentials,
      BuildContext context, File image) async {
    
  }

  @override
  Future<void> addtoCart(Map<String, String> cartProductData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('cart_orders')
        .add({
      'title': cartProductData['title'],
      'price': cartProductData['price'],
      'product_img_url': cartProductData['product_img_url'],
    });
  }

  @override
  Future<void> orderProduct() async {
    var data = FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('cart_orders')
        .get();
    data
        .then((value) => value.docs.forEach((element) async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(_firebaseAuth.currentUser!.uid)
                  .collection('orders')
                  .add({
                "title": element['title'],
                "price": element['price'],
                'product_img_url': element['product_img_url'],
                'time': DateTime.now()
              });
            }))
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('cart_orders')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    });
  }

  @override
  Future<void> deleteCartItem(String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('cart_orders')
        .doc(id)
        .delete();
  }

  
}
