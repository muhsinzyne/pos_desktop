import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/order-payment/controllers/delivery_order_payment_controller.dart';

class DeliveryOrderPaymentScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryOrderPaymentScreenController>(
        DeliveryOrderPaymentScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
