import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardScreenController>(
      () => DashboardScreenController(),
    );
  }
}
