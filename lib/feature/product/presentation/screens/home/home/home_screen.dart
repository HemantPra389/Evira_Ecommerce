import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'product_detail_screen.dart';
import 'search_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/asset_constants.dart' as asset;

import '../../../bloc/cubit/product_cubit.dart';
import '../../../widgets/home_app_bar.dart';
import '../../../widgets/product_grid.dart';
import 'carousel_list.dart';
import 'most_popular_product_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routename = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String category = "clothes";
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar('Good Morning', context),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: mediaQuery.height * .1,
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * .04,
                  vertical: mediaQuery.height * .02),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
                },
                child: TextFormField(
                  style: asset.introStyles(20),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: IconTheme(
                        data: const IconThemeData(color: Colors.grey, size: 30),
                        child: const Icon(Icons.search_rounded),
                      ),
                      hintText: 'Search',
                      prefixIconColor: Colors.grey,
                      hintStyle: asset.introStyles(18, color: Colors.black45),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: asset.buttoncolour, width: 1.5)),
                      filled: true,
                      enabled: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: mediaQuery.height * .02),
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * .04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Newly Added',
                    style: asset.introStyles(18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: mediaQuery.width * .02,
              ),
              margin: EdgeInsets.only(bottom: mediaQuery.height * .01),
              height: mediaQuery.height * .34,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .orderBy('createdAt', descending: true)
                      .limit(5)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black87,
                          strokeWidth: 7,
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;
                      return AnimationLimiter(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.fast),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              horizontalOffset: 150,
                              child: FadeInAnimation(
                                child: SizedBox(
                                  width: mediaQuery.width * .5,
                                  child: GestureDetector(
                                    onTap: () {
                                      try {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => ProductCubit(),
                                            child: ProductDetailScreen(
                                                id: data[index]['id']),
                                          ),
                                        ));
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 4),
                                      margin: EdgeInsets.only(
                                          right: mediaQuery.width * .02,
                                          bottom: 8,
                                          top: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.blueGrey.shade100,
                                                blurRadius: 1,
                                                spreadRadius: .5),
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: mediaQuery.height * .2,
                                            width: mediaQuery.width * .5,
                                            child: Image.network(
                                              data[index]['imageUrls'][0]
                                                  as String,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data[index]['title'],
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: asset.introStyles(16,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height:
                                                      mediaQuery.height * .01,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      size: 16,
                                                      color: Colors.yellow,
                                                    ),
                                                    Text(
                                                      ' ${data[index]['rating'].toString()}  |   ',
                                                      style: asset.introStyles(
                                                          14,
                                                          color: Colors.grey),
                                                    ),
                                                    Container(
                                                      width: 80,
                                                      height: 20,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      color:
                                                          Colors.grey.shade300,
                                                      child: Text(
                                                        '${data[index]['sold'].toString()} sold',
                                                        style: asset
                                                            .introStyles(12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      mediaQuery.height * .01,
                                                ),
                                                Text(
                                                  '₹${double.parse(data[index]['price'].toString()).toString()}',
                                                  style: asset.introStyles(18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          itemCount: data.length,
                        ),
                      );
                    }
                  }),
            ),
            Divider(
              color: Colors.blueGrey.shade100,
              thickness: 1,
            ),
            Container(
              margin: EdgeInsets.only(top: mediaQuery.height * .01),
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * .04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: asset.introStyles(18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * .04,
                  vertical: mediaQuery.height * .02),
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString("assets/json/category.json"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    var categoryData =
                        json.decode(snapshot.data.toString()) as List<dynamic>;
                    return AnimationLimiter(
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categoryData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              columnCount: 4,
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: category_tile(
                                      categoryData[index]['icon'],
                                      categoryData[index]['title'], () {
                                    String? jsonData;
                                    jsonData = categoryData[index]['title'];
                                    jsonData = jsonData!.toLowerCase();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => ProductCubit(),
                                            child: ProductGrid(
                                              jsonData.toString(),
                                            ),
                                          ),
                                        ));
                                  }),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                },
              ),
            ),
            Divider(
              color: Colors.blueGrey.shade100,
              thickness: 1,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: mediaQuery.height * .01,
                  bottom: mediaQuery.height * .01),
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * .04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Special Offers',
                    style: asset.introStyles(18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: FirebaseStorage.instance.ref('banners').listAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: mediaQuery.height * .2,
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error loading images');
                } else {
                  var references = snapshot.data;
                  return SizedBox(
                    height: mediaQuery.height * .3,
                    child: CarouselSlider.builder(
                      itemCount: references!.items.length,
                      itemBuilder: (context, index, realIndex) {
                        return FutureBuilder<dynamic>(
                          future: references.items[index].getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error loading image');
                            } else {
                              String imageUrl = snapshot.data;
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: mediaQuery.height * .01),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(imageUrl),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                      options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1,
                          aspectRatio: 1.5),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * .04,
                  vertical: mediaQuery.height * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Popular',
                    style: asset.introStyles(18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => ProductCubit(),
                          child: MostPopularProductScreen(),
                        ),
                      ));
                    },
                    child: Text(
                      'See all',
                      style: asset.introStyles(16, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: mediaQuery.height * .04,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/json/category.json'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    var categoryData =
                        json.decode(snapshot.data.toString()) as List<dynamic>;
                    return AnimationLimiter(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset: 150,
                            child: FadeInAnimation(
                              child: asset.category_chip(
                                  categoryData[index]['title'], category),
                            ),
                          ),
                        ),
                        itemCount: categoryData.length,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: mediaQuery.height * .05,
            )
          ],
        ),
      ),
    );
  }

  InkWell category_tile(String url, String title, VoidCallback movenext) {
    return InkWell(
      onTap: () => movenext(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(25)),
            child: Image.asset(
              url,
              color: asset.buttoncolour,
              width: 30,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: asset.introStyles(14),
          )
        ],
      ),
    );
  }
}
