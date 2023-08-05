import '../screens/home/home/fav_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/asset_constants.dart' as asset;

PreferredSize MyAppBar(String title, BuildContext context) {
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
                "Home",
                style: const TextStyle(
                    color: asset.buttoncolour,
                    fontFamily: 'Ubuntu',
                    fontSize: 20),
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavScreen(),
                ));
              },
              icon: Image.asset(asset.heart,
                  width: 25, color: asset.buttoncolour),
            ),
          ],
        ),
      ));
}
