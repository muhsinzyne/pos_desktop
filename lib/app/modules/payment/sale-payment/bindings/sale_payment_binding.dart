import 'package:get/get.dart';

import '../controllers/sale_payment_controller.dart';

class SalePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalePaymentController>(
      () => SalePaymentController(),
    );
  }
}
