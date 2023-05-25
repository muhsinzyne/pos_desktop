import 'dart:io';

import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/dashboard/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/response/auth/open_register_response.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/location_service.dart';
import 'dart:async';

import 'package:posdelivery/models/requests/auth/open_register_request.dart';
import 'package:posdelivery/models/requests/auth/register_close_summary_request.dart';
class NewDashboardScreenController extends BaseGetXController
    implements INewDashboardScreenController {
  final TextEditingController openingBalanceInput =  TextEditingController();

  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  OpenRegisterRequest openRegisterRequest = OpenRegisterRequest();
  @override
  void onInit(){
    deliveryDataProvider.newDashboardCallBack = this;
    super.onInit();
  }
  @override
  void onClose() {
    openingBalanceInput.dispose();
    super.onClose();
  }
void openRegister(){
    Get.back();
    UINotification.showLoading();
    openRegisterRequest.cashInHand = openingBalanceInput.text;
    deliveryDataProvider.openRegister(openRegisterRequest);

}
  @override
  onOpenRegisterDone(OpenRegisterResponse openRegisterResponse) {

    UINotification.hideLoading();
    Logger().w(openRegisterResponse.toJson());

  }

  @override
  onOpenRegisterError(ErrorMessage err) {

    UINotification.hideLoading();
    Logger().w(err.toJson());
  }


}