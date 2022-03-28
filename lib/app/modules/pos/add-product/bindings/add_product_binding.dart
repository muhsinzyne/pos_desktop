import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddProductController>(AddProductController());
    // Get.lazyPut<AddProductController>(
    //   () => AddProductController(),
    // );
  }
}
