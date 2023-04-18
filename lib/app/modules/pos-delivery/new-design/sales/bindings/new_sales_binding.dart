import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/controllers/new_sales_controller.dart';

class NewSalesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewSalesScreenController>(NewSalesScreenController());
  }
}
