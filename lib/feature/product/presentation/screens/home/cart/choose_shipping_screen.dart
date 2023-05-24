import 'package:flutter/material.dart';
import 'package:evira_ecommerce/core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/presentation/widgets/back_app_bar.dart';
import '../../../bloc/cubit/product_cubit.dart';
import '../../../widgets/transaction_button.dart';
import 'promo_screen.dart';

class 
ChooseShippingScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context,'Choose Shipping'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              shipping_address_tile(
                  "Economy",
                  "Estimated Arrival,Dec 21-23 ",
                  "https://cdn1.iconfinder.com/data/icons/black-round-web-icons/100/round-web-icons-black-10-512.png",
                  false,
                  "120"),
              shipping_address_tile(
                  "Regular",
                  "Estimated Arrival,Dec 20-22 ",
                  "https://cdn1.iconfinder.com/data/icons/black-round-web-icons/100/round-web-icons-black-10-512.png",
                  true,
                  "180"),
              shipping_address_tile(
                  "Cargo",
                  "Estimated Arrival,Dec 19-20 ",
                  "https://cdn1.iconfinder.com/data/icons/black-round-web-icons/100/round-web-icons-black-10-512.png",
                  false,
                  "220"),
              shipping_address_tile(
                  "Express",
                  "Estimated Arrival,Dec 18-19 ",
                  "https://cdn1.iconfinder.com/data/icons/black-round-web-icons/100/round-web-icons-black-10-512.png",
                  false,
                  "250"),
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
                            child: PromoScreen(),
                          ),
            ));
          },
        ),
      ),
    );
  }

  ListTile shipping_address_tile(String title, String address, String image,
      bool isSelected, String price) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      title: Text(
        title,
        maxLines: 2,
        style: asset.introStyles(20),
      ),
      subtitle: Text(
        address,
        style: asset.introStyles(16, color: Colors.grey),
      ),
      trailing: SizedBox(
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "₹" + price,
              style: asset.introStyles(22),
            ),
            isSelected
                ? const Icon(
                    Icons.radio_button_checked_rounded,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.radio_button_off_rounded,
                    color: Colors.black,
                  )
          ],
        ),
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
