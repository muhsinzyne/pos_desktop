import 'package:get/get.dart';

import '../controllers/pos_payment_controller.dart';

class PosPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PosPaymentController>(PosPaymentController());
    // Get.lazyPut<PosPaymentController>(
    //   () => PosPaymentController(),
    // );
  }
}
