import 'package:evira_shop/feature/feature_name/presentation/screens/home/home/product_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

class ProductCard extends StatelessWidget {
  List<dynamic> image_url;
  String title;
  String price;
  ProductCard(
      {required this.title, required this.price, required this.image_url});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(image_url,title,price)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 200,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 1,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(image_url[0].toString()),
                      )),
                    ),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          radius: 15,
                          child: Image.asset(
                            asset.heart,
                            color: Colors.white,
                            width: 22,
                          ),
                        ))
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: asset.introStyles(20, color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.star_half_outlined),
                      Text(
                        ' 4.5  |   ',
                        style: asset.introStyles(16, color: Colors.grey),
                      ),
                      Container(
                        width: 60,
                        height: 20,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.center,
                        color: Colors.grey.shade300,
                        child: Text(
                          '8,374 sold',
                          style: asset.introStyles(12),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹$price',
                    style: asset.introStyles(20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
