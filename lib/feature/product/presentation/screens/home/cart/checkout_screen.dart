import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../domain/entities/address_entity.dart';
import '../../../bloc/cubit/product_cubit.dart';
import '../profile/address_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../../../../../../core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:upi_india/upi_india.dart';

import '../../../../../auth/presentation/widgets/back_app_bar.dart';
import '../../../widgets/cart_product_card.dart';
import '../../../widgets/transaction_button.dart';

class CheckoutScreen extends StatefulWidget {
  double amount;
  CheckoutScreen({required this.amount});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Map<String, String> cartProductData = {
    'title': '',
    'price': '',
    'product_img_url': ''
  };

  var firebasefirestore = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;
  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAppBar(context, 'Checkout'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mediaquery.width * .04,
                vertical: mediaquery.height * .02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  style: asset.introStyles(18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                ValueListenableBuilder(
                  valueListenable: Hive.box<AddressEntity>(asset.hiveaddressbox)
                      .listenable(),
                  builder: (context, favbox, child) {
                    if (favbox
                        .containsKey(FirebaseAuth.instance.currentUser!.uid)) {
                      return shipping_address_tile(
                        favbox.values.first.landmark,
                        favbox.values.first.address,
                        () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddressScreen(),
                          ));
                        },
                      );
                    } else {
                      return shipping_address_tile(
                        "Add Landmark",
                        '''Add Address''',
                        () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddressScreen(),
                          ));
                        },
                      );
                    }
                  },
                ),
                SizedBox(
                  height: mediaquery.height * .02,
                ),
                Text(
                  'Orders List',
                  style: asset.introStyles(18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          StreamBuilder(
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
                    cartProductData['title'] = document['title'];
                    cartProductData['price'] = document['price'];
                    cartProductData['imageUrl'] = document['imageUrl'];
                    return CartProductCard(
                        isCart: true,
                        id: document['id'],
                        sold: document['sold'],
                        rating: document['rating'],
                        quantity: document['quantity'],
                        imageUrl: document['imageUrl'],
                        title: document['title'],
                        price: document['price']);
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
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: TransactionButton(
          titleSize: 18,
          mediaQuery: MediaQuery.of(context).size.width * .9,
          verticalpadding: 20,
          title: 'Continue to Payment',
          suffixIcon: const Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
            size: 18,
          ),
          trasaction_fun: () async {
            BlocProvider.of<ProductCubit>(context).orderProduct();
            //TODO:Change afterwards
            // try {
            //   await initiateTransaction(UpiApp.paytm, widget.amount);
            // } catch (e) {
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text(
            //       _upiErrorHandler(e),
            //     ),
            //     backgroundColor: Colors.red.shade700,
            //   ));
            // }
          },
        ),
      ),
    );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  Future<UpiResponse> initiateTransaction(UpiApp app, double amount) async {
    return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: "8354955584@paytm",
        receiverName: 'Hemant Prajapati',
        transactionRefId: 'TestingUpiIndiaPlugin',
        transactionNote: 'Not actual. Just an example.',
        // amount: 0,
        amount: amount);
  }

  ListTile shipping_address_tile(
      String title, String address, VoidCallback fun) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      title: Text(
        title,
        maxLines: 2,
        style: asset.introStyles(16)..copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        address,
        style: asset.introStyles(14, color: Colors.grey),
      ),
      trailing: GestureDetector(
        onTap: fun,
        child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: asset.buttoncolour,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            )),
      ),
      leading: SizedBox(
        height: 55,
        width: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            "https://cdn1.iconfinder.com/data/icons/black-round-web-icons/100/round-web-icons-black-10-512.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
