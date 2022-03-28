import 'package:get/get.dart';
import 'package:posdelivery/app/modules/add_expense/controllers/add_expense_controller.dart';
import 'package:posdelivery/app/modules/home/contracts.dart';
import 'package:posdelivery/app/modules/sales_point/controllers/sales_point_controller.dart';
import 'package:posdelivery/controllers/base_controller.dart';

class HomeController extends BaseGetXController implements IHomeController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
