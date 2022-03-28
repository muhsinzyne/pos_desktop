import 'package:get/get.dart';

import '../controllers/customer_payment_controller.dart';

class CustomerPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CustomerPaymentController>(CustomerPaymentController());
    // Get.lazyPut<CustomerPaymentController>(
    //   () => CustomerPaymentController(),
    // );
  }
}
