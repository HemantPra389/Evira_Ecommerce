import 'package:evira_shop/feature/feature_name/presentation/widgets/cart_product_card.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/default_app_bar.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/home_app_bar.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;
import 'package:evira_shop/feature/feature_name/presentation/widgets/transaction_button.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routename = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: DefaultAppBar('My Cart'),
      body: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: CartProductCard(
            productQuantity: 2,
          ),
        ),
        itemCount: 10,
      ),
      bottomNavigationBar: Container(
        height: mediaQuery.height * .1,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 13),
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
                    '₹3,999',
                    style: asset.introStyles(28),
                  )
                ],
              ),
              TransactionButton(
                mediaQuery: mediaQuery.width * .65,
                title: 'Checkout',
                suffixIcon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                trasaction_fun: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
