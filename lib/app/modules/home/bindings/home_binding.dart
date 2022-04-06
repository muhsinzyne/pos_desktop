import 'package:get/get.dart';
import 'package:posdelivery/app/modules/add_expense/controllers/add_expense_controller.dart';
import 'package:posdelivery/app/modules/close_register/controllers/close_register_controller.dart';
import 'package:posdelivery/app/modules/product_list/controllers/product_list_controller.dart';
import 'package:posdelivery/app/modules/register_details/controllers/register_details_controller.dart';

import '../../sales_point/controllers/sales_point_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
    Get.lazyPut<AddExpenseController>(
      () => AddExpenseController(),
    );
    Get.lazyPut<SalesPointController>(
      () => SalesPointController(),
    );
    Get.lazyPut<CloseRegisterController>(
      () => CloseRegisterController(),
    );
    Get.lazyPut<RegisterDetailsController>(
      () => RegisterDetailsController(),
    );
    Get.lazyPut<ProductListController>(
      () => ProductListController(),
    );
  }
}
