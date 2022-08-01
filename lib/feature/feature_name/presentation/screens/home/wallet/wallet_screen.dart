import 'package:evira_shop/feature/feature_name/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
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
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '₹2,54,856',
                      style: asset.introStyles(50),
                    )
                  ],
                ),
                Icon(
                  Icons.refresh_rounded,
                  color: Colors.black54,
                )
              ]),
              SizedBox(
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
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: [
                    transaction_history_tile(
                        'Suga Lether Shoes',
                        'Dec 15, 2024 | 10:00 AM',
                        '₹599',
                        'Orders',
                        "https://rukminim1.flixcart.com/image/753/904/kpmy8i80/shoe/q/w/p/9-ajwings-magnolia-white-original-imag3thhuz3edrjg.jpeg?q=50"),
                    transaction_history_tile(
                        'Top Up Wallet',
                        'Dec 14, 2024 | 10:00 AM',
                        '₹2000',
                        'Top Up',
                        "https://static.thenounproject.com/png/2464489-200.png"),
                    transaction_history_tile(
                        'Realme Buds',
                        'Dec 11, 2024 | 10:00 AM',
                        '₹1299',
                        'Orders',
                        "https://rukminim1.flixcart.com/image/416/416/krayqa80/headphone/x/9/r/rma2010-realme-original-imag54ey5mxggzcy.jpeg?q=70"),
                    transaction_history_tile(
                        'Boat HeadPhone',
                        'Dec 5, 2024 | 10:00 AM',
                        '₹3990',
                        'Orders',
                        "https://rukminim1.flixcart.com/image/416/416/kq9ta4w0/headphone/5/b/3/rockerz-650-boat-original-imag4bfgnqmjpbem.jpeg?q=70"),
                    transaction_history_tile(
                        'Top Up Wallet',
                        'Dec 14, 2024 | 10:00 AM',
                        '₹599',
                        'Top Up',
                        "https://static.thenounproject.com/png/2464489-200.png"),
                    transaction_history_tile(
                        'Track Bag',
                        'Nov 15, 2024 | 10:00 AM',
                        '₹899',
                        'Orders',
                        "https://rukminim1.flixcart.com/image/753/904/l111lzk0/backpack/s/i/d/unisex-water-proof-mountain-rucksackhiking-trekking-camping-bag-original-imagcztjcmrrshdf.jpeg?q=50"),
                    transaction_history_tile(
                        'Top Up Wallet',
                        'Dec 14, 2024 | 10:00 AM',
                        '₹16590',
                        'Top Up',
                        "https://static.thenounproject.com/png/2464489-200.png"),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  ListTile transaction_history_tile(
      String title, String date, String rate, String typeOf, String image) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 6),
      title: Text(
        title,
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
            rate,
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
