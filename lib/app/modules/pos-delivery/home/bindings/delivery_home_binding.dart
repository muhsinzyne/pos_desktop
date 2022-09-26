import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/home/controllers/delivery_home_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/splash/controllers/delivery_splash_controller.dart';
import 'package:posdelivery/controllers/app_controller.dart';

class DeliveryHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryHomeScreenController>(DeliveryHomeScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
