import 'package:flutter/material.dart';

class AppLanguages {
  static const Locale en_US = Locale('en', 'US');
  static const Locale ar_SA = Locale('ar', 'SA');

  static const List<Locale> languageList = [en_US, ar_SA];
}

class AppLocale {
  final Locale locale;
  final String label;
  final String icon;
  AppLocale(this.locale, this.label, this.icon);

  static AppLocale en = AppLocale(AppLanguages.en_US, 'english', 'assets/icons/united-states.png');
  static AppLocale ar = AppLocale(AppLanguages.ar_SA, 'arabic', 'assets/icons/saudi-arabia.png');
  static List<AppLocale> appLocalList = [en, ar];
}
