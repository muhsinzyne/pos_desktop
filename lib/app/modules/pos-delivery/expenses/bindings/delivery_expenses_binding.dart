import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-expenses/controllers/delivery_add_expenses_controller.dart';

class DeliveryExpensesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryAddExpensesScreenController>(
      () => DeliveryAddExpensesScreenController(),
    );
  }
}
