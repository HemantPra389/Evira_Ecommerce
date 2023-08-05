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
    final String productId = cartProductData['id']!;
    final String userId = _firebaseAuth.currentUser!.uid;

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart_orders');

    final existingProductSnapshot =
        await cartRef.where('id', isEqualTo: productId).get();

    if (existingProductSnapshot.docs.isNotEmpty) {
      // Product already exists in the cart, increase quantity
      final existingProduct = existingProductSnapshot.docs.first;
      int currentQuantity = existingProduct['quantity'] ?? 0;
      await existingProduct.reference.update({'quantity': currentQuantity + 1});
    } else {
      // Product doesn't exist in the cart, add it
      await cartRef.add({
        'id': cartProductData['id'],
        'title': cartProductData['title'],
        'imageUrl': cartProductData['imageUrl'],
        'quantity': 1,
        'rating': cartProductData['rating'],
        'sold': cartProductData['sold'],
        'price': cartProductData['price'],
      });
    }
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
                'id': element['id'],
                'title': element['title'],
                'status': "ongoing",
                'imageUrl': element['imageUrl'],
                'quantity': element['quantity'],
                'rating': element['rating'],
                'sold': element['sold'],
                'price': element['price'],
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
    var userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      var data = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart_orders')
          .where('id', isEqualTo: id)
          .get();
      for (var doc in data.docs) {
        await doc.reference.delete();
      }
    }
  }
}
