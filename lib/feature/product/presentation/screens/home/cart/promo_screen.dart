import 'package:evira_shop/feature/product/presentation/bloc/cubit/product/product_cubit.dart';
import 'package:evira_shop/feature/product/presentation/widgets/back_app_bar.dart';
import 'package:evira_shop/feature/product/presentation/widgets/transaction_button.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'payment_screen.dart';

class PromoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, 'Add Promo'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              shipping_address_tile(
                  "Special 25% Off", "Special promo only for today", false),
              shipping_address_tile(
                  "Discount 30% Off", "New user special promo", false),
              shipping_address_tile(
                  "Special 20% Off", "Special promo only for today", false),
              shipping_address_tile(
                  "Discount 30% Off", "New arrival discount ", false),
              shipping_address_tile(
                  "Discount 35% Off", "Special promo only for today ", false),
              shipping_address_tile("Discount 45% Off",
                  "Latest Special heavy discount only for today", true),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: TransactionButton(
          mediaQuery: MediaQuery.of(context).size.width * .9,
          verticalpadding: 20,
          title: 'Apply',
          suffixIcon: const SizedBox(),
          trasaction_fun: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ProductCubit(),
                child: PaymentScreen(),
              ),
            ));
          },
        ),
      ),
    );
  }

  ListTile shipping_address_tile(String title, String desc, bool isSelected) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      title: Text(
        title,
        maxLines: 2,
        style: asset.introStyles(20),
      ),
      subtitle: Text(
        desc,
        style: asset.introStyles(16, color: Colors.grey),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: isSelected
            ? const Icon(
                Icons.radio_button_checked_rounded,
                color: Colors.black,
              )
            : const Icon(
                Icons.radio_button_off_rounded,
                color: Colors.black,
              ),
      ),
      leading: SizedBox(
        height: 55,
        width: 55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            "https://thumbs.dreamstime.com/b/gift-box-icon-surprise-black-white-vector-illustration-226582068.jpg",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
