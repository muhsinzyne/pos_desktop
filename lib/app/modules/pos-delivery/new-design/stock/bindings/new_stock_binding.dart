import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/stock/controllers/new_stock_controller.dart';

class NewStockScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewStockScreenController>(NewStockScreenController());
  }
}
