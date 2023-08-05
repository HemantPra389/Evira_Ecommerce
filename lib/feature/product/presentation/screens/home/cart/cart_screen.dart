import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../core/asset_constants.dart' as asset;
import '../home/product_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/product_cubit.dart';
import '../../../widgets/cart_product_card.dart';
import '../../../widgets/default_app_bar.dart';
import '../../../widgets/transaction_button.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  static const routename = '/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> productsIds = [];
  Future<List<String>> productIdsList() async {
    var listofidsData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart_orders')
        .get();
    listofidsData.docs.forEach((element) {
      productsIds.add(element['id']);
    });
    print(productsIds);
    return productsIds;
  }

  @override
  Widget build(BuildContext context) {
    var firebasefirestore = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: DefaultAppBar('My Cart'),
      body: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: StreamBuilder(
          stream: firebasefirestore.collection('cart_orders').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black87,
                  strokeWidth: 7,
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.size != 0) {
              return ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: snapshot.data!.docs.map((document) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: CartProductCard(
                          isCart: true,
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

            double price_data = 0;
            for (var data in document) {
              String receive_price =
                  (double.parse(data['price']) * data['quantity']).toString();
              if (receive_price.contains(',')) {
                price_data += double.parse(receive_price.replaceAll(',', ''));
              } else {
                price_data += double.parse(receive_price);
              }
            }
            return SizedBox(
              height: mediaQuery.height * .1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey.shade100,
                      offset: Offset(-1, 0),
                      spreadRadius: 1,
                      blurRadius: 1)
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: mediaQuery.height * .05,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Total Price',
                            style: asset.introStyles(16),
                          ),
                          Text(
                            "₹" + asset.numberFormat(price_data),
                            style: asset.introStyles(20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    TransactionButton(
                      mediaQuery: mediaQuery.width * .65,
                      title: 'Checkout',
                      suffixIcon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      trasaction_fun: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => ProductCubit(),
                            child: CheckoutScreen(amount: price_data),
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
