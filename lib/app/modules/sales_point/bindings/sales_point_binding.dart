import 'package:get/get.dart';

import '../controllers/sales_point_controller.dart';

class SalesPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesPointController>(
      () => SalesPointController(),
    );
  }
}
