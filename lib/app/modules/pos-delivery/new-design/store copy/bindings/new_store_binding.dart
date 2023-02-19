import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';

class NewStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewStoreScreenController>(
      () => NewStoreScreenController(),
    );
  }
}
