import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/register-history/controllers/delivery_register_history_controller.dart';

class DeliveryRegisterHistoryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryRegisterHistoryScreenController>(
        DeliveryRegisterHistoryScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
