import 'package:get/get.dart';

import '../controllers/licence_screen_controller.dart';

class LicenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LicenceScreenController>(LicenceScreenController());
  }
}
