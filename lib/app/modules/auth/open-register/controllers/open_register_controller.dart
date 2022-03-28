import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/auth/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/requests/auth/open_register_request.dart';
import 'package:posdelivery/models/response/auth/open_register_response.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

class OpenRegisterController extends BaseGetXController implements IOpenRegisterController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  RxBool disabledFormFiled = RxBool(false);

  TextEditingController cashInHand = TextEditingController();

  @override
  void onInit() {
    posDataProvider.openRegisterCallBack = this;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  actionOpenRegister() {
    UINotification.showLoading();
    OpenRegisterRequest openRegisterRequest = OpenRegisterRequest();
    openRegisterRequest.cashInHand = cashInHand.text;
    posDataProvider.openRegister(openRegisterRequest);
  }

  @override
  void onOpenRegisterDone(OpenRegisterResponse openRegisterResponse) {
    UINotification.hideLoading();
    if (openRegisterResponse.status == true) {
      UINotification.showNotification(color: Colors.green, title: openRegisterResponse.message);
      Get.back();
    } else {
      UINotification.showNotification(color: Colors.red, title: openRegisterResponse.message);
    }
  }

  @override
  void onOpenRegisterError(ErrorMessage errorMessage) {
    UINotification.hideLoading();
    UINotification.showNotification(color: Colors.red, title: errorMessage.message);
  }
}
