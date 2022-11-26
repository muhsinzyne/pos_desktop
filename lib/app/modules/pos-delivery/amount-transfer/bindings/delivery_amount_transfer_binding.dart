import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/select-store/controllers/delivery_select_store_controller.dart';
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
