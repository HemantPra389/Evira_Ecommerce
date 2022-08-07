import 'package:flutter/material.dart';

PreferredSize BackAppBar(
  BuildContext context,String title,
) {
  return PreferredSize(
      child: SafeArea(
        child: Container(
          child: AppBar(
            elevation: 0,
            primary: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            titleSpacing: 10,
            title: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon:
                        const Icon(Icons.arrow_back_ios, color: Colors.black)),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Ubuntu', fontSize: 23),
                )
              ],
            ),
          ),
        ),
      ),
      preferredSize: const Size.fromHeight(60));
}
