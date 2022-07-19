import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/controllers/delivery_add_manually_store_controller.dart';

class DeliveryAddStoreManuallyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryAddStoreManuallyScreenController>(
        DeliveryAddStoreManuallyScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
