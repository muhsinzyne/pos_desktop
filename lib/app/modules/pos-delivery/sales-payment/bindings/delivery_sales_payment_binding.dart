import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/sales-payment/controllers/delivery_sales_payment_controller.dart';

class DeliverySalesPaymentScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliverySalesPaymentScreenController>(
        DeliverySalesPaymentScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
