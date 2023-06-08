import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/controllers/delivery_add_manually_store_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/profile/controllers/new_profile_controller.dart';

class NewProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewProfileScreenController>(
      () => NewProfileScreenController(),
    );
  }
}
