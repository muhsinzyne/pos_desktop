import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:posdelivery/app/config/flavor/flavor_service.dart';
import 'package:posdelivery/app/locator.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/generated/locales.g.dart';
import 'package:posdelivery/models/app_languages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';
import 'pre_app.dart';

void main() async {
  runApp(const PreApp());
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  FlavorConfig(
    flavor: Flavor.development,
    flavorValues: AppFlavors.devFlavor,
  );
  AppServiceBinding().dependencies();
  await Future.delayed(Duration(
    seconds: 1,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GetMaterialApp(
        //smartManagement: SmartManagement.full,
        theme: ThemeData(
          //platform: TargetPlatform.android,
          fontFamily: fontFamily,
          colorScheme: ColorScheme.light().copyWith(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.appBarColor,
            titleTextStyle: kBaseTextStyle,
          ),
          scaffoldBackgroundColor: AppColors.secondary,
        ),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        /*
          Localisation config

         */

        locale: Get.deviceLocale,
        //locale: AppLanguages.ar_SA,
        fallbackLocale: AppLanguages.en_US,
        translationsKeys: AppTranslation.translations,
        title: "app_title".tr,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}
