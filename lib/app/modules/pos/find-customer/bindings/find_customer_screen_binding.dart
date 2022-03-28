import 'package:get/get.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

import '../controllers/find_customer_controller.dart';

class FindCustomerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindCustomerScreenController>(
      () => FindCustomerScreenController(),
    );
    try {
      Get.put<PosDataProvider>(PosDataProvider());
    } catch (e) {
      print("all ready loaded");
    }
  }
}
