import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/auth/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/requests/auth/validate_licence.dart';
import 'package:posdelivery/models/response/auth/licence_validation_response.dart';
import 'package:posdelivery/models/response/error_message.dart';

class LicenceScreenController extends BaseGetXController implements ILicenceScreenController {
  RxBool continuePermission = RxBool(false);
  RxString licenceCode = RxString('');

  @override
  void onInit() {
    // when licence code reaches max limit
    authDataProvider.licenceValidationCallback = this;
    ever(licenceCode, (_) {
      if (licenceCode.value.length == Constants.licenceCodeLength) {
        continuePermission.value = true;
      } else {
        continuePermission.value = false;
      }
    });
    super.onInit();
  }

  void actionLicenceValidate() async {
    isLoading.value = true;
    //print(licenceCode.value);
    final ValidateLicenceRequest vLReq = ValidateLicenceRequest();
    vLReq.licenceCode = licenceCode.value;
    vLReq.appMode = Constants.ios;
    vLReq.appId = '3424-3-4sdsdsd-343434';
    print(vLReq.toJson());
    authDataProvider.validateLicence(vLReq);
    // await Future.delayed(Duration(seconds: 1));
    // isLoading.value = false;
    // onLicenceVerificationDone();
  }

  @override
  void onLicenceVerificationDone(LicenceValidationResponse lvR) async {
    if (lvR.api != null) {
      print(lvR);
      appService.appServer = lvR.api.toString();
      appService.appPrefix = lvR.appPrefix.toString();
      Get.snackbar(
        'verified'.tr,
        'licence_verified_please_login_your_account'.tr,
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      await Future.delayed(Constants.smallDuration);
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  void onLicenceVerificationError(ErrorMessage errMsg) {
    isLoading.value = false;
    Get.snackbar(
      'error'.tr,
      errMsg.message.toString(),
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }
}
