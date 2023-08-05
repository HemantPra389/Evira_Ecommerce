import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/asset_constants.dart' as asset;
import '../../../widgets/cart_product_card.dart';

class OnGoingOrder extends StatelessWidget {
  var firebasefirestore = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebasefirestore
          .collection('orders')
          .where('status', isEqualTo: "ongoing")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black87,
              strokeWidth: 7,
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.size != 0) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: snapshot.data!.docs.map((document) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CartProductCard(
                      isShowfav: false,
                      id: document['id'],
                      rating: document['rating'],
                      quantity: document['quantity'],
                      sold: document['sold'],
                      imageUrl: document['imageUrl'],
                      title: document['title'],
                      price: document['price']));
            }).toList(),
          );
        } else {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(asset.empty_cart_error, width: 300),
              const SizedBox(
                height: 20,
              ),
              Text(
                'No Orders Yet',
                textAlign: TextAlign.center,
                style: asset.introStyles(22, color: Colors.black54),
              )
            ]),
          );
        }
      },
    );
  }
}
