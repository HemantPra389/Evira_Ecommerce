import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_shop/feature/product/presentation/widgets/default_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    var firebasefirestore = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
        appBar: DefaultAppBar('My E-Wallet'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Balance',
                      style: asset.introStyles(20, color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '₹2,54,856',
                      style: asset.introStyles(50),
                    )
                  ],
                ),
                const Icon(
                  Icons.refresh_rounded,
                  color: Colors.black54,
                )
              ]),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction History',
                    style: asset.introStyles(24),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'See all',
                      style: asset.introStyles(18),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: firebasefirestore.collection('orders').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black87,
                            strokeWidth: 7,
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data!.size != 0) {
                        return ListView(
                          children: snapshot.data!.docs.map((document) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: transaction_history_tile(
                                    document['title'],
                                    "Dec 11,2021 | 11:20 AM",
                                    document['price'],
                                    "Order",
                                    document['product_img_url']));
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
                                  'No Transaction right now',
                                  textAlign: TextAlign.center,
                                  style: asset.introStyles(22,
                                      color: Colors.black54),
                                )
                              ]),
                        );
                      }
                    }),
              )
            ],
          ),
        ));
  }

  ListTile transaction_history_tile(
      String title, String date, String rate, String typeOf, String image) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      title: Text(
        title,
        maxLines: 2,
        style: asset.introStyles(20),
      ),
      subtitle: Text(
        date,
        style: asset.introStyles(16, color: Colors.grey),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹" + rate,
            style: asset.introStyles(22),
          ),
          Text(
            typeOf,
            style: asset.introStyles(16, color: Colors.grey),
          )
        ],
      ),
      leading: SizedBox(
        height: 55,
        width: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
