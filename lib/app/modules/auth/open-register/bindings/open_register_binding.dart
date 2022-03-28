import 'package:get/get.dart';

import '../controllers/open_register_controller.dart';

class OpenRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpenRegisterController>(
      () => OpenRegisterController(),
    );
  }
}
