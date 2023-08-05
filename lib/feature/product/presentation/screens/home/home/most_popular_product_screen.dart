import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../../../core/asset_constants.dart' as asset;
import '../../../../../auth/presentation/widgets/back_app_bar.dart';
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
                      return AnimationLimiter(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.fast),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                horizontalOffset: 150.0,
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        category = categoryData[index]['title'];
                                        category = category.toLowerCase();
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 2.0),
                                      child: asset.category_chip(
                                          categoryData[index]['title'],
                                          category),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: categoryData.length,
                        ),
                      );
                    }
                  },
                ),
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('products')
                    .where("category", isEqualTo: category)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black87,
                        strokeWidth: 7,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    var data = snapshot.data!.docs;

                    return Expanded(
                      child: AnimationLimiter(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.fast),
                          itemCount: data.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: .62,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 12),
                          itemBuilder: (context, index) =>
                              AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            columnCount: 2,
                            child: SlideAnimation(
                              verticalOffset: 150.0,
                              child: ProductCard(
                                id: data[index]['id'],
                                title: data[index]['title'],
                                price: double.parse(
                                        data[index]['price'].toString())
                                    .toString(),
                                rating: data[index]['rating'].toString(),
                                sold: data[index]['sold'].toString(),
                                image_url:
                                    data[index]['imageUrls'][0] as String,
                                category: data[index]['category'],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
