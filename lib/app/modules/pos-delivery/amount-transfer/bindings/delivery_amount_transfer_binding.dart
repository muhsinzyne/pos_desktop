import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_add_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/amount-transfer/controllers/delivery_amount_transfer_controller.dart';

class DeliveryAmountTransferScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryAmountTransferScreenController>(
        DeliveryAmountTransferScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
