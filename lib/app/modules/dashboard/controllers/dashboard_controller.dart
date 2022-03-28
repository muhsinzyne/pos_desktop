import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/dashboard/contracts.dart';
import 'package:posdelivery/app/modules/dashboard/views/find_customer_search.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/requests/auth/register_close_summary_request.dart';
import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

class DashboardScreenController extends BaseGetXController
    implements IDashboardScreenController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  var cRegister = CurrentRegisterResponse().obs;
  var registerCloseSummary = RegisterCloseSummary().obs;
  actionGoSales() {
    Get.toNamed(Routes.findCustomer)?.then((value) {
      _fetchMyData();
    });
  }

  actionGoReturns() {}
  actionGoSalesHistory() {
    Get.toNamed(Routes.salesList)?.then((value) {
      _fetchMyData();
    });
  }

  actionGoPayments(BuildContext context) {
    actionSearchCustomer(context);
  }

  actionOnCustomers() {
    Get.toNamed(Routes.customerList)?.then((value) {
      _fetchMyData();
    });
  }

  actionPOSSalesWindow() {
    Get.toNamed(Routes.homePos)?.then((value) => _fetchMyData());
  }

  actionSearchCustomer(BuildContext context) {
    showSearch(context: context, delegate: FindCustomerSearch()).then((value) {
      _fetchMyData();
    });
  }

  @override
  void onInit() {
    posDataProvider.dashboardCallBack = this;
    super.onInit();
  }

  @override
  void onReady() {
    _fetchMyData();
    super.onReady();
  }

  _fetchMyData() {
    UINotification.showLoading();
    posDataProvider.myRegisterSummary();
  }

  @override
  onCurrentRegisterNotOpen(ErrorMessage errorMessage) {
    UINotification.hideLoading();
    UINotification.showNotification(
      color: AppColors.red,
      title: errorMessage.message,
    );
    Get.toNamed(Routes.openRegister)?.then((value) {
      _fetchMyData();
    });
  }

  @override
  onCurrentRegisterResponseDone(
      CurrentRegisterResponse currentRegisterResponse) {
    RegisterCloseSummaryRequest rRequest = RegisterCloseSummaryRequest();
    cRegister.value = currentRegisterResponse;
    rRequest.registerId = currentRegisterResponse.id;
    posDataProvider.registerCloseSummaryForDashBoard(rRequest);
  }

  @override
  onRegisterCloseSummaryDone(RegisterCloseSummary rSummary) {
    UINotification.hideLoading();
    registerCloseSummary.value = rSummary;
    print(rSummary.toJson());
  }

  @override
  onRegisterCloseSummaryError(ErrorMessage errorMessage) {
    UINotification.hideLoading();
    UINotification.showNotification(
      color: AppColors.red,
      title: errorMessage.message,
    );
  }
}
