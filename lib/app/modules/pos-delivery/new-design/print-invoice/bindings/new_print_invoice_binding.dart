import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/print-invoice/controllers/new_print_invoice_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/sale-invoice/controllers/delivery_sale_invoice_controller.dart';

class NewPrintInvoiceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewPrintInvoiceScreenController>(NewPrintInvoiceScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
