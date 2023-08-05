import 'package:flutter/material.dart';
import '../../../../core/asset_constants.dart' as asset;

class TransactionButton extends StatelessWidget {
  final double mediaQuery;
  String title;
  double titleSize;
  double middlepadding;
  double verticalpadding;
  Widget? suffixIcon;
  VoidCallback trasaction_fun;

  TransactionButton(
      {required this.mediaQuery,
      required this.title,
      this.titleSize = 16,
      this.middlepadding = 20,
      this.verticalpadding = 18,
      required this.suffixIcon,
      required this.trasaction_fun});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: trasaction_fun,
      child: Container(
        width: mediaQuery,
        padding: EdgeInsets.symmetric(
          vertical: verticalpadding,
        ),
        decoration: BoxDecoration(
            color: asset.buttoncolour,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(1.5, 1.5))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: asset.introStyles(titleSize, color: Colors.white),
            ),
            SizedBox(
              width: middlepadding,
            ),
            suffixIcon!
          ],
        ),
      ),
    );
  }
}
