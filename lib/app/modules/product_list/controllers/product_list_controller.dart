import 'package:get/get.dart';
import 'package:posdelivery/controllers/base_controller.dart';

import '../../../../models/response/pos/product.dart';

class ProductListController extends BaseGetXController {
  //TODO: Implement ProductListController

  final count = 0.obs;
  RxList<Product> productList = RxList([]);
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
