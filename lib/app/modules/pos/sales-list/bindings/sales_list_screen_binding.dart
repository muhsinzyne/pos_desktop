import 'package:get/get.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

import '../controllers/sales_list_screen_controller.dart';

class SalesListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PosDataProvider>(PosDataProvider());
    Get.put<SalesListScreenController>(SalesListScreenController());
  }
}
