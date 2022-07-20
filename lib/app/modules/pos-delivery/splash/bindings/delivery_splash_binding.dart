import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/splash/controllers/delivery_splash_controller.dart';

class DeliverySplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliverySplashScreenController>(DeliverySplashScreenController());
  }
}
