import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:evira_ecommerce/core/asset_constants.dart' as asset;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/presentation/widgets/back_app_bar.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../bloc/cubit/product_cubit.dart';
import '../../../widgets/product_card.dart';

class MostPopularProductScreen extends StatefulWidget {
  static const routename = "/most-popular-product-screen";

  @override
  State<MostPopularProductScreen> createState() =>
      _MostPopularProductScreenState();
}

class _MostPopularProductScreenState extends State<MostPopularProductScreen> {
  String category = "clothes";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, "Most Popular"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/json/category.json'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      var categoryData = json.decode(snapshot.data.toString())
                          as List<dynamic>;
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                category = categoryData[index]['title'];
                                category = category.toLowerCase();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: asset.category_chip(
                                  categoryData[index]['title'], category),
                            ),
                          );
                        },
                        itemCount: categoryData.length,
                      );
                    }
                  },
                ),
              ),
              FutureBuilder(
                  future: BlocProvider.of<ProductCubit>(context)
                      .getProductData(category),
                  builder:
                      (context, AsyncSnapshot<List<ProductEntity>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black87,
                          strokeWidth: 7,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: GridView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: .65,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 7),
                            itemBuilder: (context, index) => ProductCard(
                                title: snapshot.data![index].title,
                                price: snapshot.data![index].price,
                                image_url: snapshot.data![index].url,
                                category: snapshot.data![index].category,)),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
