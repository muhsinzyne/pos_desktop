import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-orders/controllers/delivery_add_orders_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/select-store/controllers/delivery_select_store_controller.dart';

class DeliveryAddOrdersScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryAddOrdersScreenController>(
        DeliveryAddOrdersScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
