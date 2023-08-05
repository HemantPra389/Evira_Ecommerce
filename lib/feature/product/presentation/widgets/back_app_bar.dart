import 'package:flutter/material.dart';
import '../../../../core/asset_constants.dart' as asset;

PreferredSize BackAppBar(
  BuildContext context,
  String title,
) {
  return PreferredSize(
      child: SafeArea(
        child: Container(
          child: AppBar(
            elevation: 2,
            primary: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            titleSpacing: 10,
            title: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: asset.buttoncolour,
                      size: 16,
                    )),
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
        ),
      ),
      preferredSize: const Size.fromHeight(55));
}
