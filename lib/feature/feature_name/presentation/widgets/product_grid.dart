import 'dart:convert';

import 'package:evira_shop/feature/feature_name/domain/entities/product_entity.dart';
import 'package:evira_shop/feature/feature_name/presentation/bloc/cubit/product_cubit.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  String jsonPath;
  String title;
  ProductGrid(this.jsonPath, this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(title),
      body: FutureBuilder(
          future:
              BlocProvider.of<ProductCubit>(context).getProductData(jsonPath),
          builder: (context, AsyncSnapshot<List<ProductEntity>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black87,
                  strokeWidth: 7,
                ),
              );
            } else {
              return GridView.builder(
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .65,
                      crossAxisCount: 2,
                      crossAxisSpacing: 7),
                  itemBuilder: (context, index) => ProductCard(
                      title: snapshot.data![index].title,
                      price: snapshot.data![index].price,
                      image_url: snapshot.data![index].url));
            }
          }),
    );
  }
}
