import 'package:get/get.dart';
import 'package:posdelivery/controllers/app_controller.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
    Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
