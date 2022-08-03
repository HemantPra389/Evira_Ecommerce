import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:evira_shop/feature/feature_name/presentation/bloc/cubit/product/product_cubit.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/home_app_bar.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/carousel_card.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/input_field.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

import 'carousel_list.dart';
import 'carousel_list.dart';
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
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: Scaffold(
        appBar: MyAppBar('Good Morning'),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InputField('Search', Icon(Icons.search_rounded),(v){},
                  Icon(Icons.menu_open_outlined)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Special Offers',
                    style: asset.introStyles(22),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => ProductCubit(),
                              child: CarouselList(),
                            ),
                          ));
                    },
                    child: Text(
                      'See all',
                      style: asset.introStyles(18),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(1, 2))
                  ],
                ),
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString("assets/json/carousel.json"),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        var carouselData = json.decode(snapshot.data.toString())
                            as List<dynamic>;
                        List<Widget> itemsList = [];
                        for (int i = 0; i < carouselData.length; i++) {
                          itemsList.add(CarouselCard(
                              carouselData[i]['discount'],
                              carouselData[i]['heading'],
                              carouselData[i]['subtitle'],
                              carouselData[i]['image_url']));
                        }

                        return CarouselSlider(
                          items: itemsList,
                          options: CarouselOptions(
                              autoPlay: true, viewportFraction: 1),
                        );
                      }
                    }),
              ),
              FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString("assets/json/category.json"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    var categoryData =
                        json.decode(snapshot.data.toString()) as List<dynamic>;
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: categoryData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return category_tile(categoryData[index]['icon'],
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
                                        jsonData![0].toUpperCase() +
                                            jsonData.substring(1)),
                                  ),
                                ));
                          });
                        });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Popular',
                    style: asset.introStyles(22),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, MostPopularProductScreen.routename);
                    },
                    child: Text(
                      'See all',
                      style: asset.introStyles(18),
                    ),
                  ),
                ],
              ),
              Container(
                height: 60,
                child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/json/category.json'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      var categoryData = json.decode(snapshot.data.toString())
                          as List<dynamic>;
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => asset.category_chip(
                            categoryData[index]['title'], category),
                        itemCount: categoryData.length,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
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
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(25)),
            child: Image.asset(
              url,
              width: 30,
            ),
          ),
          SizedBox(
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
