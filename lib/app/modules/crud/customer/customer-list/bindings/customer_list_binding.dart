import 'package:get/get.dart';

import '../controllers/customer_list_controller.dart';

class CustomerListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerListController>(
      () => CustomerListController(),
    );
  }
}
