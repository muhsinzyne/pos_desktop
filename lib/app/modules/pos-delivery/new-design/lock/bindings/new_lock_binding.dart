import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/lock/controllers/new_lock_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/quotations/controllers/new_quotations_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/controllers/new_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';

class NewLockScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewLockScreenController>(
      () => NewLockScreenController(),
    );
  }
}
