import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/requests/auth/register_close_summary_request.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/location_service.dart';
import 'dart:async';
import 'package:posdelivery/app/modules/pos-delivery/new-design/dashboard/controllers/new_dashboard_controller.dart';

import '../contracts.dart';

class NewFinancialScreenController extends BaseGetXController implements INewFinancialScreenController
   {
RxString cashInHand =''.obs;
RxString salesValue =''.obs;
RxString stockValue =''.obs;
RxString returnValue =''.obs;
RxString duePayment ='0'.obs;
RxString storesServed =''.obs;

  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
 NewDashboardScreenController dashboardCtrl = Get.find<NewDashboardScreenController>();
RegisterCloseSummaryRequest registerCloseSummaryRequest = RegisterCloseSummaryRequest();


  @override
  void onInit() {
deliveryDataProvider.newFinancialCallBack = this;
registerCloseSummaryRequest.registerId = dashboardCtrl.currentRegister?.id??'';
deliveryDataProvider.registerCloseSummaryFinancial(registerCloseSummaryRequest);
    super.onInit();
  }

  @override
  void onReady()async {
    await Future.delayed(const Duration(milliseconds: 10));
    UINotification.showLoading();
    super.onReady();
  }



  @override
  onRegisterCloseSummaryDone(RegisterCloseSummary rSummary) {
    cashInHand.value = rSummary.cashInHand??'0';
    salesValue.value = rSummary.saleAmount.toStringAsFixed(2)??'';
    stockValue.value = rSummary.totalSales?.total??'0';
    returnValue.value = rSummary.returns?.total ??'0';
    storesServed.value = rSummary.saleCount.toString();
    UINotification.hideLoading();

  }

  @override
  onRegisterCloseSummaryError(ErrorMessage errorMessage) {
    Logger().e(errorMessage.message);
    UINotification.hideLoading();
  }
}

