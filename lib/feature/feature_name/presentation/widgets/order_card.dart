import 'package:evira_shop/feature/feature_name/presentation/widgets/transaction_button.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

class OrderCard extends StatelessWidget {
  String status;
  OrderCard(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 2,
            )
          ],
          color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 145,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(
                  "https://rukminim1.flixcart.com/image/416/416/krayqa80/headphone/x/9/r/rma2010-realme-original-imag54ey5mxggzcy.jpeg?q=70",
                ))),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Realme Buds Q2',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: asset.introStyles(24),
                    ),
                    status == 'In Delivery'
                        ? Icon(
                            Icons.delete,
                            color: Colors.black54,
                          )
                        : Container()
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle),
                    Text(
                      '   Color',
                      style: asset.introStyles(16, color: Colors.black54),
                    )
                  ],
                ),
                Container(
                  width: 70,
                  height: 20,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    status == 'In Delivery' ? 'In Delivery' : 'Completed',
                    style: asset.introStyles(12),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹3,999',
                      style: asset.introStyles(24),
                    ),
                    TransactionButton(
                        mediaQuery: 120,
                        title: status == 'In Delivery'
                            ? 'Track Order'
                            : 'Leave Review',
                        titleSize: 16,
                        middlepadding: 2,
                        verticalpadding: 5,
                        suffixIcon: status == 'In Delivery'
                            ? Icon(
                                Icons.track_changes_outlined,
                                color: Colors.white,
                              )
                            : Container(),
                        trasaction_fun: () {})
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
