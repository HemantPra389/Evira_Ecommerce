import 'package:evira_ecommerce/feature/product/presentation/widgets/transaction_button.dart';
import 'package:flutter/material.dart';
import 'package:evira_ecommerce/core/asset_constants.dart' as asset;

class OrderCard extends StatelessWidget {
  String status;
  String title;
  String image_url;
  String price;
  OrderCard(
      {required this.status,
      required this.title,
      required this.price,
      required this.image_url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(right: 10, bottom: 7, top: 7),
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
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(
                  image_url,
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
                    SizedBox(
                      width: 150,
                      child: Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: asset.introStyles(20),
                      ),
                    ),
                    status == 'In Delivery'
                        ? const Icon(
                            Icons.delete,
                            color: Colors.black54,
                          )
                        : Container()
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.circle),
                    Text(
                      '   Color',
                      style: asset.introStyles(16, color: Colors.black54),
                    )
                  ],
                ),
                Container(
                  width: 70,
                  height: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
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
                      '₹' + price,
                      style: asset.introStyles(22),
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
                            ? const Icon(
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
    
  }
}
