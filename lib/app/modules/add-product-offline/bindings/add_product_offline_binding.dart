import 'package:get/get.dart';

import '../controllers/add_product_offline_controller.dart';

class AddProductOfflineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductOfflineController>(
      () => AddProductOfflineController(),
    );
  }
}
