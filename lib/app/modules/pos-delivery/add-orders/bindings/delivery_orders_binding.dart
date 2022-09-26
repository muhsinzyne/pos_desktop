import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-orders/controllers/delivery_orders_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';

class DeliveryOrdersScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryOrdersScreenController>(DeliveryOrdersScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
