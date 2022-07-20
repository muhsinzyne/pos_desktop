// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class TextFieldDelivery extends StatelessWidget {
  final String hint;
  IconData? icon;
  final int maxLine;
  TextFieldDelivery({
    Key? key,
    this.hint = "",
    this.maxLine = 1,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLine,
      decoration: InputDecoration(
          suffixIcon: icon != null
              ? Icon(
                  Icons.search_outlined,
                  size: 30,
                )
              : null,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                width: 0,
                color: AppColors.deliverySecondary,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                width: 0,
                // color: Color.fromARGB(0, 194, 106, 34),
                style: BorderStyle.solid,
              )),
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          fillColor: Color(0x99E5E5E5)),
    );
  }
}
