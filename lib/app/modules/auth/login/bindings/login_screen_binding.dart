import 'package:get/get.dart';

import '../controllers/login_screen_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(
      () => LoginScreenController(),
    );
  }
}
