import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class TextFieldDelivery extends StatelessWidget {
  final String hint;
  IconData? icon;
  bool onlyRead = false;
  TextEditingController? controller;
  final int maxLine;
  TextFieldDelivery(
      {Key? key,
      this.hint = "",
      this.maxLine = 1,
      this.icon,
      this.controller,
      this.onlyRead = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: onlyRead,
      // isDense
      maxLines: maxLine,

      decoration: InputDecoration(
          suffixIcon: icon != null
              ? const Icon(
                  Icons.search_outlined,
                  size: 30,
                )
              : null,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                width: 0,
                color: AppColors.deliverySecondary,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                width: 0,
                // color: Color.fromARGB(0, 194, 106, 34),
                style: BorderStyle.solid,
              )),
          filled: true,
          hintText: hint,
          isDense: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
          fillColor: const Color(0xffE5E5E5).withOpacity(0.3)),
    );
  }
}
