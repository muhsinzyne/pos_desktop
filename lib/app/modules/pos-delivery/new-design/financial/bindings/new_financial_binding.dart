import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/controllers/delivery_add_manually_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/add-store/controllers/new_add_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/dashboard/controllers/new_dashboard_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/financial/controllers/new_financial_controller.dart';

class NewFinancialScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewFinancialScreenController>(
      () => NewFinancialScreenController(),
    );
  }
}
