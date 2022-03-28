import 'package:get/get.dart';

import '../controllers/add_expense_controller.dart';

class AddExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddExpenseController>(
      () => AddExpenseController(),
    );
  }
}
