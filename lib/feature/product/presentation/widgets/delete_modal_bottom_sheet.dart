import 'package:flutter/material.dart';
import 'package:evira_ecommerce/core/asset_constants.dart' as asset;

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
                  children: [
                    const Icon(Icons.circle),
                    Text(
                      '   Color',
                      style: asset.introStyles(14, color: Colors.black54),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹" + price,
                      style: asset.introStyles(20),
                    ),
                    Container(
                        width: 90,
                        padding:
                            const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.remove),
                            Text(
                              "1",
                              style: asset.introStyles(16),
                            ),
                            const Icon(Icons.add)
                          ],
                        ))
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
