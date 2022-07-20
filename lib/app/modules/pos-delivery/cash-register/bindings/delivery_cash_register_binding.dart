import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_add_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/cash-register/controllers/delivery_cash_register_controller.dart';

class DeliveryCashRegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryCashRegisterScreenController>(
        DeliveryCashRegisterScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
