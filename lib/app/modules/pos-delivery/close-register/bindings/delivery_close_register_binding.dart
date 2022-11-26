import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/select-store/controllers/delivery_select_store_controller.dart';
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
