import 'package:get/get.dart';

import '../controllers/customer_view_controller.dart';

class CustomerViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerViewController>(
      () => CustomerViewController(),
    );
  }
}
