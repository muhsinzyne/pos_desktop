import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/config/flavor/flavor_service.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/models/app_languages.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/services/app_service.dart';
import 'package:uuid/uuid.dart';

class AppController extends GetxController {
  AppService? appService;
  Uuid uuid = Uuid();
  GlobalKey<ScaffoldState> appDrawerKey = GlobalKey<ScaffoldState>();
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();
  }

  void changeAppLanguage(Locale requestLocale) {
    if (requestLocale.countryCode != '' && requestLocale.languageCode != '') {
      Get.updateLocale(requestLocale);
    } else {
      // same language requesting again
    }
  }

  void _closeDrawer() {
    if (appDrawerKey.currentState!.isDrawerOpen) {
      appDrawerKey.currentState!.openEndDrawer();
    }
  }

  void toggleLanguage() {
    if (Get.locale == AppLanguages.en_US) {
      Get.updateLocale(AppLanguages.ar_SA);
    } else {
      Get.updateLocale(AppLanguages.en_US);
    }
  }

  void appClearKeyboardFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void appBarLogout() async {
    _closeDrawer();
    UINotification.showLoading();
    appService!.authToken = Constants.none;
    await Future.delayed(Constants.oneSecDuration);
    UINotification.hideLoading();
    Get.offNamed(Routes.login);
  }

  void actionChangeLanguage() {
    _closeDrawer();
    Get.toNamed(Routes.changeLanguage);
  }

  void actionMyAccount() {
    _closeDrawer();
    Get.toNamed(Routes.myAccount);
  }

  void playSound(PlaySound type) {
    switch (type) {
      case PlaySound.success:
        audioCache.play('sounds/walmart_scanner.mp3');
        break;
      case PlaySound.error:
        FlutterBeep.beep(false);
        break;
      default:
        break;
    }
  }

  demo() {}

  String get appVersion {
    try {
      return " ${Constants.version} ${appService!.packageInfo!.version} - ${appService!.packageInfo!.buildNumber}";
    } on Exception {
      return Constants.version;
    }
  }
}
