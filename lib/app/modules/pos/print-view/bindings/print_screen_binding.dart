import 'package:get/get.dart';

import '../controllers/print_screen_controller.dart';

class PrintScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PrintScreenController>(PrintScreenController());
    // Get.lazyPut<PrintViewController>(
    //   () => PrintViewController(),
    // );
  }
}
