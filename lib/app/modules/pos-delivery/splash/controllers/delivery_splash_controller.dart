import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posdelivery/app/modules/splash/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/controllers/base_controller.dart';

class DeliverySplashScreenController extends BaseGetXController
    implements ISplashScreenController {
  @override
  void onInit() {
    authDataProvider.homeCallBack = this;
    super.validateLicence();
    super.onInit();
  }
}
