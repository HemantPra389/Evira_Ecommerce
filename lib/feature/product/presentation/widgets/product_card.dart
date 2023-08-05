import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../core/asset_constants.dart' as asset;
import '../../domain/entities/cart_product_entity.dart';
import '../bloc/cubit/product_cubit.dart';
import '../screens/home/home/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  String image_url;
  String title;
  String price;
  String id;
  String rating;
  String sold;
  String category;
  ProductCard(
      {required this.title,
      required this.price,
      required this.id,
      required this.rating,
      required this.sold,
      required this.image_url,
      required this.category});
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => ProductCubit(),
                      child: ProductDetailScreen(id: id),
                    )));
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.blueGrey.shade100, blurRadius: 2, spreadRadius: 1),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(image_url.toString()),
                      )),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                          onTap: () {
                            if (Hive.box<CartProductEntity>(asset.hivefavbox)
                                .containsKey(id)) {
                              Hive.box<CartProductEntity>(asset.hivefavbox)
                                  .delete(id);
                            } else {
                              Hive.box<CartProductEntity>(asset.hivefavbox).put(
                                  id,
                                  CartProductEntity(
                                      id: id,
                                      title: title,
                                      price: double.parse(price),
                                      imageUrl: image_url,
                                      rating: rating,
                                      sold: sold));
                            }
                          },
                          child: ValueListenableBuilder(
                            valueListenable:
                                Hive.box<CartProductEntity>(asset.hivefavbox)
                                    .listenable(),
                            builder: (context, favbox, _) {
                              if (!favbox.containsKey(id)) {
                                return CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  radius: 15,
                                  child: Image.asset(
                                    asset.heart,
                                    color: Colors.white,
                                    width: 22,
                                  ),
                                );
                              } else {
                                return CircleAvatar(
                                    backgroundColor: Colors.pinkAccent,
                                    radius: 15,
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ));
                              }
                            },
                          )),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: asset.introStyles(16, color: Colors.black),
                  ),
                  SizedBox(
                    height: mediaQuery.height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.yellow,
                      ),
                      Text(
                        ' $rating  |   ',
                        style: asset.introStyles(14, color: Colors.grey),
                      ),
                      Container(
                        width: 80,
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.centerLeft,
                        color: Colors.grey.shade300,
                        child: Text(
                          '$sold sold',
                          style: asset.introStyles(12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mediaQuery.height * .01,
                  ),
                  Text(
                    '₹$price',
                    style: asset.introStyles(18, fontWeight: FontWeight.bold),
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
