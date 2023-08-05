import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/cart_product_entity.dart';
import '../screens/home/home/product_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../bloc/cubit/product_cubit.dart';
import 'delete_modal_bottom_sheet.dart';

class CartProductCard extends StatefulWidget {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String rating;
  final String sold;
  final int quantity;
  final bool isCart;
  final bool isShowfav;

  const CartProductCard(
      {super.key,
      required this.id,
      required this.sold,
      this.isCart = false,
      required this.rating,
      required this.price,
      required this.title,
      this.quantity = 0,
      this.isShowfav = true,
      required this.imageUrl});

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  Future<void> deleteProduct() async {
    var userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      var data = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart_orders')
          .where('id', isEqualTo: widget.id)
          .get();
      for (var doc in data.docs) {
        await doc.reference.delete().whenComplete(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProductCubit(),
            child: ProductDetailScreen(id: widget.id),
          ),
        ));
      },
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * .04,
            vertical: mediaQuery.height * .005),
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * .02,
            vertical: mediaQuery.height * .01),
        height:
            widget.isShowfav ? mediaQuery.height * .2 : mediaQuery.height * .15,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.blueGrey.shade100,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 1))
        ], color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: mediaQuery.height * .12,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.width * .05,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: mediaQuery.width * .5,
                              child: Text(
                                widget.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            RatingBar.builder(
                              itemSize: 16,
                              initialRating: double.parse(widget.rating) <= 1
                                  ? 1
                                  : double.parse(widget.rating),
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.only(right: 4),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Text(
                              '${widget.rating} Rated',
                              style: asset.introStyles(14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mediaQuery.height * .005,
                        ),
                        widget.quantity == 0
                            ? Text('${int.parse(widget.sold) + 110} Sold')
                            : Text('Quantity | ${widget.quantity}'),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: mediaQuery.width * .2,
                              child: Text(
                                "₹${asset.numberFormat(double.parse(widget.price))}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.isShowfav)
              Divider(
                thickness: 1,
                color: Colors.blueGrey.shade100,
              ),
            if (widget.isShowfav)
              Container(
                alignment: Alignment.center,
                height: mediaQuery.height * .04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.isCart)
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<ProductCubit>(context)
                              .deleteCartProduct(widget.id);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.blueGrey,
                              size: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Remove from cart",
                              style:
                                  asset.introStyles(16, color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                    if (widget.isCart)
                      SizedBox(
                        height: mediaQuery.height * .02,
                        child: VerticalDivider(
                          color: Colors.blueGrey,
                          width: 8,
                          thickness: 1,
                        ),
                      ),
                    GestureDetector(
                        onTap: () {
                          if (Hive.box<CartProductEntity>(asset.hivefavbox)
                              .containsKey(widget.id)) {
                            Hive.box<CartProductEntity>(asset.hivefavbox)
                                .delete(widget.id);
                          } else {
                            Hive.box<CartProductEntity>(asset.hivefavbox).put(
                                widget.id,
                                CartProductEntity(
                                    id: widget.id,
                                    title: widget.title,
                                    price: double.parse(widget.price),
                                    imageUrl: widget.imageUrl,
                                    rating: widget.rating,
                                    sold: widget.sold));
                          }
                        },
                        child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box<CartProductEntity>(asset.hivefavbox)
                                  .listenable(),
                          builder: (context, favbox, _) {
                            if (!favbox.containsKey(widget.id)) {
                              return Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.blueGrey,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Add to Favourites",
                                    style: asset.introStyles(16,
                                        color: Colors.blueGrey),
                                  ),
                                ],
                              );
                            } else {
                              return Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Added to Favourites",
                                    style: asset.introStyles(16,
                                        color: Colors.blueGrey),
                                  ),
                                ],
                              );
                            }
                          },
                        )),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
