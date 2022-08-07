import 'package:evira_shop/feature/feature_name/presentation/bloc/cubit/product/product_cubit.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/delete_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductCard extends StatelessWidget {
  int productQuantity;
  String product_id;
  String cartImageUrl;
  String title;
  bool is_delete = true;
  String price;
  CartProductCard(
    this.is_delete, {
    required this.productQuantity,
    required this.product_id,
    required this.cartImageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
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
            width: 120,
            height: 145,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(
                  cartImageUrl,
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
                      width: 160,
                      child: Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: asset.introStyles(22),
                      ),
                    ),
                    if (is_delete)
                      BlocProvider(
                        create: (context) => ProductCubit(),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (_) {
                                return BlocProvider(
                                  create: (context) => ProductCubit(),
                                  child: Container(
                                    height: 300,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Remove From Cart',
                                            style: asset.introStyles(30),
                                          ),
                                          DeleteModalBottomSheet(
                                              title: title,
                                              price: price,
                                              img_url: cartImageUrl),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              delete_decision("Cancel", () {
                                                Navigator.of(context).pop();
                                              }, Colors.black12,
                                                  Colors.black54),
                                              delete_decision("Yes, Remove",
                                                  () {
                                                BlocProvider.of<ProductCubit>(
                                                        context)
                                                    .deleteCartProduct(
                                                        product_id)
                                                    .then((value) =>
                                                        Navigator.pop(context));
                                              }, Colors.black87.withOpacity(.8),
                                                  Colors.white),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.black54,
                            size: 24,
                          ),
                        ),
                      )
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹" + price,
                      style: asset.introStyles(24),
                    ),
                    Container(
                        width: is_delete ? 90 : 30,
                        padding:
                            const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (is_delete) const Icon(Icons.remove),
                            Text(
                              productQuantity.toString(),
                              style: asset.introStyles(20),
                            ),
                            if (is_delete) const Icon(Icons.add)
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

  InkWell delete_decision(
      String title, VoidCallback fun, Color color, Color textColor) {
    return InkWell(
      onTap: fun,
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  offset: const Offset(1, 1),
                  spreadRadius: 2,
                  blurRadius: 2)
            ]),
        child: Text(
          title,
          style:
              TextStyle(color: textColor, fontFamily: 'Ubuntu', fontSize: 18),
        ),
      ),
    );
  }
}
