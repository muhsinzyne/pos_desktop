import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/order-invoice/controllers/delivery_order_invoice_controller.dart';

class DeliveryOrderInvoiceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryOrderInvoiceScreenController>(
        DeliveryOrderInvoiceScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
