import 'package:get/get.dart';

import '../controllers/edit_product_controller.dart';

class EditProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EditProductController>(EditProductController());
  }
}
