import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/basket/controllers/new_basket_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/complete-sale/controllers/new_complete_sale_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/controllers/new_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';

class NewCompleteSaleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewCompleteSaleScreenController>(
      () => NewCompleteSaleScreenController(),
    );
  }
}
