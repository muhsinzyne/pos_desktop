import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/select-store/controllers/delivery_select_store_controller.dart';

class DeliverySelectStoreScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliverySelectStoreScreenController>(
        DeliverySelectStoreScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
