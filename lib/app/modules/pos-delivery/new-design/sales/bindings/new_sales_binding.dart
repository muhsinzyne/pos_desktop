import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/controllers/new_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';

class NewSalesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewSalesScreenController>(
      () => NewSalesScreenController(),
    );
  }
}
