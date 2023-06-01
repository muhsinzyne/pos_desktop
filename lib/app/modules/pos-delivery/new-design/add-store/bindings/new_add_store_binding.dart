import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/controllers/delivery_add_manually_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/add-store/controllers/new_add_store_controller.dart';

class NewAddStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAddStoreScreenController>(
      () => NewAddStoreScreenController(),
    );
  }
}
