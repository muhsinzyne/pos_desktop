import 'package:get/get.dart';

import '../controllers/pos_bill_screen_controller.dart';

class PosBillScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosBillScreenController>(
      () => PosBillScreenController(),
    );
  }
}
