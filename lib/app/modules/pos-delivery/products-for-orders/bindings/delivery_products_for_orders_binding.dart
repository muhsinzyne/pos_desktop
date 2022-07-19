import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/products-for-orders/controllers/delivery_products_for_orders_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/products-for-sales/controllers/delivery_products_for_sales_controller.dart';

class DeliveryProductsForOrdersScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryProductsForOrdersScreenController>(
        DeliveryProductsForOrdersScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
