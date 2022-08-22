import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/payment-invoice/controllers/delivery_payment_invoice_controller.dart';

class DeliveryPaymentInvoiceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryPaymentInvoiceScreenController>(
        DeliveryPaymentInvoiceScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
