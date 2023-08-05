import 'package:flutter/material.dart';
import '../../../../core/asset_constants.dart' as asset;

PreferredSize DefaultAppBar(
  String title,
) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(55),
      child: SafeArea(
        child: AppBar(
          elevation: 1,
          primary: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          titleSpacing: 10,
          title: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(asset.logo1),
              ),
              Text(
                title,
                style: const TextStyle(
                    color: asset.buttoncolour,
                    fontFamily: 'Ubuntu',
                    fontSize: 20),
              )
            ],
          ),
        ),
      ));
}
