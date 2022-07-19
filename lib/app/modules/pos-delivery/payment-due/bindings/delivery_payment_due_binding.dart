import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/payment-due/controllers/delivery_payment_due_controller.dart';

class DeliveryPaymentDueScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryPaymentDueScreenController>(
        DeliveryPaymentDueScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
