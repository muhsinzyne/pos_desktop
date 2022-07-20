import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/products-for-sales/controllers/delivery_products_for_sales_controller.dart';

class DeliveryProductsForSalesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryProductsForSalesScreenController>(
        DeliveryProductsForSalesScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
