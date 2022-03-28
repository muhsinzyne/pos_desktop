import 'package:get/get.dart';

import '../controllers/close_register_controller.dart';

class CloseRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CloseRegisterController>(
      () => CloseRegisterController(),
    );
  }
}
