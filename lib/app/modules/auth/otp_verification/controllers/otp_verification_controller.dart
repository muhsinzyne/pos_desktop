import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:posdelivery/app/modules/auth/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/requests/auth/check_otp_request.dart';
import 'package:posdelivery/models/response/auth/check_otp_respose.dart';

class OtpVerificationController extends BaseGetXController implements IOtpVerificationController {
  @override
  void onInit() {
    ever(_otpValue, (_) => autoValidate());
    authDataProvider.otpVerificationCallback = this;
    super.onInit();
  }

  final _otpValue = RxString('');
  String _oldValidationValue = '';

  StreamController<ErrorAnimationType> otpErrorController = StreamController<ErrorAnimationType>();

  set otpValue(String value) {
    _otpValue.value = value;
  }

  autoValidate() {
    if (_otpValue.value.length == Constants.otpLength) {
      if (_oldValidationValue != _otpValue.value) {
        CheckOtpRequest otpRequest = CheckOtpRequest();
        otpRequest.otp = _otpValue.value;
        _validateToken(otpRequest);
      } else {
        _triggerInvalidOtp();
      }

      _oldValidationValue = _otpValue.value;
    }
  }

  _validateToken(CheckOtpRequest otpRequest) {
    ///authDataProvider.checkOtp(otpRequest);
  }

  _triggerInvalidOtp() {
    appService.isLastLoggedIn = false;
    otpErrorController.add(ErrorAnimationType.shake);
    Get.snackbar(
      'error'.tr,
      'otp_verification_invalid'.tr,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onVerificationDone(CheckOtpResponse otpResponse) async {
    // TODO: implement onVerificationDone
    UINotification.hideLoading();
    appService.isLastLoggedIn = true;
    appService.authToken = otpResponse.token.toString();
    Get.snackbar(
      'success'.tr,
      'otp_verification_success'.tr,
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
    await Future.delayed(Duration(seconds: 1));
    Get.offAllNamed(Routes.dashboard);
  }

  @override
  void onVerificationError() {
    _triggerInvalidOtp();
  }
}
