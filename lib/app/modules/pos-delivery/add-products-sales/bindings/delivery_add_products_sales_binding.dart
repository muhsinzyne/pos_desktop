import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-sales/controllers/delivery_add_products_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/select-store/controllers/delivery_select_store_controller.dart';

class DeliveryAddProductsSalesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryAddProductsSalesScreenController>(
        DeliveryAddProductsSalesScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
