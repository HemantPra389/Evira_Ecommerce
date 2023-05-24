import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;

import '../../../domain/entities/carousel_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../models/carousel_model.dart';
import '../../models/product_model.dart';
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

    //Helps once to upload all json product to firebase
    
    // await FirebaseFirestore.instance.collection('products').add({
    //   'id':FirebaseFirestore.instance.collection('products').doc().path,
    //   'title': cartProductData['title'],
    //   'price': cartProductData['price'],
    //   'product_img_url': cartProductData['product_img_url'],
    //   'category': cartProductData['category'],
    //   'quantity': 200,
    //   'sale': true,
    //   'featured': true,
    //   'total_orders':0
    // });
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
