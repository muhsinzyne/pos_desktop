import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/pending-payments/controllers/new_pending_payments_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/quotations/controllers/new_quotations_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/controllers/new_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';

class NewPendingPaymentsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPendingPaymentsScreenController>(
      () => NewPendingPaymentsScreenController(),
    );
  }
}