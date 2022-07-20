import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_add_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/close-register/controllers/delivery_close_register_controller.dart';

class DeliveryCloseRegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryCloseRegisterScreenController>(
        DeliveryCloseRegisterScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
