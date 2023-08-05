import 'package:flutter/material.dart';

import '../../../../core/asset_constants.dart' as asset;

class InputField extends StatefulWidget {
  final String title;
  final Widget? iconData;
  Widget? suffixIcon;
  bool obsecureText = false;
  ValueChanged<String>? fun;
  InputField(this.title, this.fun,
      [this.iconData, this.suffixIcon, this.obsecureText = false]);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: asset.introStyles(20),
      obscureText: widget.obsecureText,
      onChanged: widget.fun,
      validator: (value) {},
      decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: IconTheme(
            data: const IconThemeData(color: Colors.grey, size: 30),
            child: widget.iconData != null
                ? IconTheme(
                    data: const IconThemeData(color: Colors.grey, size: 30),
                    child: widget.iconData!,
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
          ),
          hintText: widget.title,
          prefixIconColor: Colors.grey,
          suffixIcon: widget.suffixIcon != null
              ? IconTheme(
                  data: const IconThemeData(color: Colors.grey, size: 30),
                  child: widget.suffixIcon!,
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
          hintStyle: asset.introStyles(18, color: Colors.black45),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: asset.buttoncolour, width: 1.5)),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12))),
    );
  }
}
