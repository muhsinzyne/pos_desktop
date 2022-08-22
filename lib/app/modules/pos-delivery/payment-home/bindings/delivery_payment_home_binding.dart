import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/payment-home/controllers/delivery_payment_home_controller.dart';

class DeliveryPaymentHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryPaymentHomeScreenController>(
        DeliveryPaymentHomeScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
