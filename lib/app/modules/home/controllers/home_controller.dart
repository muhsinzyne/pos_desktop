// import 'package:get/get.dart';
import 'package:posdelivery/app/modules/home/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
// import 'package:posdelivery/models/cache_db_path.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
// import 'package:posdelivery/services/cache/cache_service.dart';

class HomeController extends BaseGetXController implements IHomeController {
  //TODO: Implement HomeController

  // CacheService cache = Get.find<CacheService>();
  MyInfoResponse info = MyInfoResponse();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    UINotification.showLoading();
    Future.delayed(const Duration(seconds: 2))
        .whenComplete(() => UINotification.hideLoading());
    super.onReady();
  }

  @override
  void onClose() {}
}
