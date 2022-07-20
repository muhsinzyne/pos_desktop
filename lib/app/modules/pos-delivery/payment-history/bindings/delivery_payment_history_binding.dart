import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/payment-history/controllers/delivery_payment_history_controller.dart';

class DeliveryPaymentHistoryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryPaymentHistoryScreenController>(
        DeliveryPaymentHistoryScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
