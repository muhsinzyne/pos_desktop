import 'package:get/get.dart';

import '../controllers/customer_add_controller.dart';

class CustomerAddBinding extends Bindings {
  @override
  void dependencies() {
    //Get.put<CustomerAddController>(CustomerAddController());
    Get.lazyPut<CustomerAddController>(
      () => CustomerAddController(),
    );
  }
}
