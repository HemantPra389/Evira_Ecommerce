import 'package:evira_shop/feature/feature_name/presentation/bloc/cubit/product/product_cubit.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/back_app_bar.dart';
import 'package:evira_shop/feature/feature_name/presentation/widgets/carousel_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselList extends StatelessWidget {
  static const routename = '/carousel_list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context,"Special Offers"),
      body: FutureBuilder(
        future: BlocProvider.of<ProductCubit>(context).getCarouselData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:  CircularProgressIndicator(
              color: Colors.black87,
              strokeWidth: 7,
            ));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(1, 1.1))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CarouselCard(
                    snapshot.data[index].discount,
                    snapshot.data[index].heading,
                    snapshot.data[index].subtitle,
                    snapshot.data[index].image_url),
              ),
              itemCount: snapshot.data.length,
            );
          }
        },
      ),
    );
  }
}
