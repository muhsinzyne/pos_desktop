import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/store-details/controllers/delivery_store_details_controller.dart';

class DeliveryStoreDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DeliveryStoreDetailsScreenController>(
        DeliveryStoreDetailsScreenController());
    // Get.lazyPut<AppController>(() => AppController());
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
  }
}
