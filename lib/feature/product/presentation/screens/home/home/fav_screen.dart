import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../widgets/back_app_bar.dart';
import '../../../widgets/cart_product_card.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/asset_constants.dart' as asset;
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../domain/entities/cart_product_entity.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BackAppBar(context, "Wishlist"),
        body: ValueListenableBuilder(
          valueListenable:
              Hive.box<CartProductEntity>(asset.hivefavbox).listenable(),
          builder: (context, favbox, _) {
            List<CartProductEntity> cartlist = favbox.values.toList();
            return AnimationLimiter(
              child: ListView.builder(
                physics: BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                itemCount: cartlist.length,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 150,
                    child: FadeInAnimation(
                      child: CartProductCard(
                          id: cartlist[index].id,
                          sold: cartlist[index].sold,
                          rating: cartlist[index].rating,
                          price: cartlist[index].price.toString(),
                          title: cartlist[index].title,
                          imageUrl: cartlist[index].imageUrl),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
