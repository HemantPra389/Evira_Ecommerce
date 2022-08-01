import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

class CartProductCard extends StatefulWidget {
  int productQuantity;
  CartProductCard({required this.productQuantity});

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
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
                      style: asset.introStyles(22),
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.black54,
                      size: 24,
                    )
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹3,999',
                      style: asset.introStyles(24),
                    ),
                    Container(
                        width: 90,
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (widget.productQuantity > 1) {
                                      widget.productQuantity--;
                                    }
                                  });
                                },
                                child: Icon(Icons.remove)),
                            Text(
                              widget.productQuantity.toString(),
                              style: asset.introStyles(20),
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.productQuantity++;
                                  });
                                },
                                child: Icon(Icons.add))
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
