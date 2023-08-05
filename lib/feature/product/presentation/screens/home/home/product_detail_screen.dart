import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../domain/entities/cart_product_entity.dart';
import '../../../bloc/cubit/product_cubit.dart';
import '../../../widgets/transaction_button.dart';

class ProductDetailScreen extends StatelessWidget {
  String id;

  ProductDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    String cartbtntitle = "Add to Cart";

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('id', isEqualTo: id)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black87,
              strokeWidth: 7,
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: mediaQuery.height * .5,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Stack(fit: StackFit.expand, children: [
                        CarouselSlider.builder(
                            itemCount: data['imageUrls'].length,
                            itemBuilder: (context, index, realIndex) =>
                                SizedBox(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Image.network(
                                        data['imageUrls'][index])),
                            options: CarouselOptions(
                                aspectRatio: 0.1,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                                viewportFraction: 1)),
                        Positioned(
                          top: 20,
                          left: 20,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(.4),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 40),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(1, -2))
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: mediaQuery.width * .8,
                                    child: Text(
                                      data['title'],
                                      style: asset.introStyles(25),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: false,
                                    ).animate().fadeIn(
                                        duration:
                                            const Duration(milliseconds: 800)),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        if (Hive.box<CartProductEntity>(
                                                asset.hivefavbox)
                                            .containsKey(id)) {
                                          Hive.box<CartProductEntity>(
                                                  asset.hivefavbox)
                                              .delete(id);
                                        } else {
                                          Hive.box<CartProductEntity>(
                                                  asset.hivefavbox)
                                              .put(
                                                  id,
                                                  CartProductEntity(
                                                      id: id,
                                                      title: data['title'],
                                                      price: data['price'],
                                                      imageUrl:
                                                          data['imageUrls'][0],
                                                      rating: data['rating']
                                                          .toString(),
                                                      sold: data['sold']
                                                          .toString()));
                                        }
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable:
                                            Hive.box<CartProductEntity>(
                                                    asset.hivefavbox)
                                                .listenable(),
                                        builder: (context, favbox, _) {
                                          if (!favbox.containsKey(id)) {
                                            return Image.asset(
                                              asset.heart,
                                              width: 28,
                                            );
                                          } else {
                                            return const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            );
                                          }
                                        },
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        itemSize: 16,
                                        initialRating: double.parse(
                                                    data["rating"]
                                                        .toString()) <=
                                                1
                                            ? 1
                                            : double.parse(
                                                data["rating"].toString()),
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding:
                                            const EdgeInsets.only(right: 4),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      Text('${data["rating"]} Rated'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Container(
                            width: 60,
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            color: Colors.grey.shade300,
                            child: Text(
                              '${data["sold"]} sold',
                              style: asset.introStyles(12),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: asset.introStyles(
                                  23,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                data['description'],
                                style: asset.introStyles(14,
                                    color: Colors.black54),
                                maxLines: null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: mediaQuery.height * .1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey.shade100,
                      offset: const Offset(-1, 0),
                      spreadRadius: 1,
                      blurRadius: 1)
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: mediaQuery.height * .05,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Total Price',
                            style: asset.introStyles(16),
                          ),
                          Text(
                            "₹${asset.numberFormat(data['price'])}",
                            style: asset.introStyles(20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    BlocConsumer<ProductCubit, ProductState>(
                      listener: (context, state) {
                        if (state is AddingCartState) {
                          cartbtntitle = 'Adding';
                        } else if (state is AddedCartSuccess) {
                          cartbtntitle = 'Added';
                        }
                      },
                      builder: (context, state) {
                        return TransactionButton(
                          mediaQuery: mediaQuery.width * .65,
                          title: cartbtntitle,
                          suffixIcon: Image.asset(
                            asset.cart,
                            color: Colors.white,
                          ),
                          trasaction_fun: () {
                            BlocProvider.of<ProductCubit>(context).addToCart({
                              'id': data['id'],
                              'imageUrl': data['imageUrls'][0],
                              'title': data['title'],
                              'price': data['price'].toString(),
                              'rating': data['rating'].toString(),
                              'sold': data['sold'].toString(),
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
