import 'package:flutter/material.dart';
import '../../../../core/asset_constants.dart' as asset;

class DeleteModalBottomSheet extends StatelessWidget {
  String img_url;
  String title;
  String price;
  DeleteModalBottomSheet(
      {required this.title, required this.price, required this.img_url});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
            width: 100,
            height: 125,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(
                  img_url,
                ))),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: asset.introStyles(20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹" + price,
                      style: asset.introStyles(20),
                    )
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
