import 'package:flutter/material.dart';
import 'package:evira_shop/core/asset_constants.dart' as asset;

class InputField extends StatelessWidget {
  final String title;
  final Widget iconData;
  Widget? suffixIcon;
  bool obsecureText = false;
  InputField(this.title, this.iconData,
      [this.suffixIcon, this.obsecureText = false]);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: asset.introStyles(20),
      obscureText: obsecureText,
      decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: IconTheme(
            data: IconThemeData(color: Colors.grey, size: 30),
            child: iconData,
          ),
          hintText: title,
          prefixIconColor: Colors.grey,
          suffixIcon: IconTheme(
            data: IconThemeData(color: Colors.grey, size: 30),
            child: suffixIcon!,
          ),
          hintStyle: asset.introStyles(18, color: Colors.black45),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black, width: 1.5)),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20))),
    );
  }
}
