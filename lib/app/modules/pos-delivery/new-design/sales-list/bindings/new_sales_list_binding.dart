import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/controllers/new_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales-list/controllers/new_sales_list_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';

class NewSalesListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewSalesListScreenController>(NewSalesListScreenController());
  }
}
