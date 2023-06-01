import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/sale-invoice/controllers/delivery_sale_invoice_controller.dart';

class DeliverySaleInvoiceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliverySaleInvoiceScreenController>(
        DeliverySaleInvoiceScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
