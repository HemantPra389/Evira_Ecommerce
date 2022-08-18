import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;
import 'package:evira_shop/feature/product/presentation/bloc/cubit/product/product_cubit.dart';
import 'package:evira_shop/feature/product/presentation/widgets/cart_product_card.dart';
import 'package:evira_shop/feature/product/presentation/widgets/default_app_bar.dart';
import 'package:evira_shop/feature/product/presentation/widgets/transaction_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  static const routename = '/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> cartProductData = {
      'title': '',
      'price': '',
      'product_img_url': ''
    };
    var firebasefirestore = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: DefaultAppBar('My Cart'),
      body: StreamBuilder(
        stream: firebasefirestore.collection('cart_orders').snapshots(),
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
                cartProductData['title'] = document['title'];
                cartProductData['price'] = document['price'];
                cartProductData['product_img_url'] =
                    document['product_img_url'];
                return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: CartProductCard(true,
                        productQuantity: 1,
                        product_id: document.id,
                        cartImageUrl: document['product_img_url'],
                        title: document['title'],
                        price: document['price']));
              }).toList(),
            );
          } else {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(asset.empty_cart_error, width: 300),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your Cart is Empty',
                      textAlign: TextAlign.center,
                      style: asset.introStyles(22, color: Colors.black54),
                    )
                  ]),
            );
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: firebasefirestore.collection('cart_orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black87,
                strokeWidth: 7,
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.size != 0) {
            var document = snapshot.data!.docs;

            int price_data = 0;
            for (var data in document) {
              String receive_price = data['price'];
              if (receive_price.contains(',')) {
                price_data +=
                    int.parse(receive_price.replaceAll(',', '')).toInt();
              } else {
                price_data += int.parse(receive_price).toInt();
              }
            }
            return SizedBox(
              height: mediaQuery.height * .1,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Total Price',
                          style: asset.introStyles(16),
                        ),
                        Text(
                          "₹" + asset.numberFormat(price_data),
                          style: asset.introStyles(28),
                        )
                      ],
                    ),
                    TransactionButton(
                      mediaQuery: mediaQuery.width * .65,
                      title: 'Checkout',
                      suffixIcon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                      trasaction_fun: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => ProductCubit(),
                            child: CheckoutScreen(),
                          ),
                        ));
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox(
              height: 0,
              width: 0,
            );
          }
        },
      ),
    );
  }
}
