import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/app_languages.dart';
import 'package:posdelivery/models/constants.dart';

TextStyle kBaseTextStyle = TextStyle(
  //color: AppColors.primary,
  fontSize: 20,
);

String get fontFamily => Get.locale == AppLanguages.ar_SA ? 'DIN Next LT Arabic' : 'Roboto';
String get fontFamilyReverse => Get.locale != AppLanguages.ar_SA ? 'DIN Next LT Arabic' : 'Roboto';
String get arabic => Constants.dinNextLTArabic;
String get english => Constants.roboto;
InputBorder kInputBorderEnabled = OutlineInputBorder(
    //borderSide: BorderSide(color: AppColors.secondary),
    );
InputBorder kInputBorderFocus = OutlineInputBorder(
  borderSide: BorderSide(color: AppColors.primary),
);

InputBorder kInputBorderDisabled = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
);

InputBorder kInputBorderError = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.red),
);
