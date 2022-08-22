import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/open-register/controllers/delivery_open_register_controller.dart';

class DeliveryOpenRegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryOpenRegisterScreenController>(
        DeliveryOpenRegisterScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
