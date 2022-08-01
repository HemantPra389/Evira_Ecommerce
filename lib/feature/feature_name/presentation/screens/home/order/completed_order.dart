import 'package:evira_shop/feature/feature_name/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';

class CompletedOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: OrderCard('Completed')),
        itemCount: 10,
      ),
    );
  }
}
