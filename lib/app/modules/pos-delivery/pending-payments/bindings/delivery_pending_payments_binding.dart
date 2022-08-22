import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/pending-payments/controllers/delivery_pending_payments_controller.dart';

class DeliveryPendingPaymentScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryPendingPaymentScreenController>(
        DeliveryPendingPaymentScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
