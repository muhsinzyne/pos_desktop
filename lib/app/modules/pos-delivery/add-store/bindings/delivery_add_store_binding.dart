import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store/controllers/delivery_add_store_controller.dart';

class DeliveryAddStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryAddStoreScreenController>(
        DeliveryAddStoreScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
