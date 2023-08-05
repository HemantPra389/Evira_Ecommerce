import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../../core/asset_constants.dart' as asset;
import '../../../auth/presentation/widgets/back_app_bar.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  String title;
  ProductGrid(this.title);

  Future<List<QueryDocumentSnapshot>> getProductsByCategory(
      String category) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where("category", isEqualTo: category)
        .get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, title),
      body: FutureBuilder(
        future: getProductsByCategory(title),
        builder:
            (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: asset.buttoncolour,
                strokeWidth: 7,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            var data = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
              ),
              child: AnimationLimiter(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  itemCount: data.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      child: FadeInAnimation(
                        child: ProductCard(
                          id: data[index]['id'],
                          title: data[index]['title'],
                          price: double.parse(data[index]['price'].toString())
                              .toString(),
                          rating: data[index]['rating'].toString(),
                          sold: data[index]['sold'].toString(),
                          image_url: data[index]['imageUrls'][0] as String,
                          category: data[index]['category'],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
