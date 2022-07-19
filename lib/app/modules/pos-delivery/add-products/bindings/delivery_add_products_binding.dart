import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products/controllers/delivery_add_products_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_add_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';

class DeliveryAddProductsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryAddProductsScreenController>(
        DeliveryAddProductsScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
