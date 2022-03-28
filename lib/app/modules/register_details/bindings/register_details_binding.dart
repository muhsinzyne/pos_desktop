import 'package:get/get.dart';

import '../controllers/register_details_controller.dart';

class RegisterDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterDetailsController>(
      () => RegisterDetailsController(),
    );
  }
}
