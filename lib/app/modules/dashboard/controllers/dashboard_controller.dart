import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/dashboard/contracts.dart';
import 'package:posdelivery/app/modules/dashboard/views/find_customer_search.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/cache_db_path.dart';
import 'package:posdelivery/models/requests/auth/register_close_summary_request.dart';
import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/response/desktop/customer_group.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/providers/data/desktop_data_provider.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/services/cache/cache_service.dart';

class DashboardScreenController extends BaseGetXController
    implements IDashboardScreenController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  CacheService cache = Get.find<CacheService>();
  DesktopDataProvider desktopDataProvider = Get.find<DesktopDataProvider>();
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
    Get.toNamed(Routes.homePos)?.then((value) => _fetchCustomerListOff());
    UINotification.showLoading();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => UINotification.hideLoading());
  }

  actionPOSSalesWindowWithoutSync() {
    Get.toNamed(Routes.homePos);
  }

  actionSearchCustomer(BuildContext context) {
    showSearch(context: context, delegate: FindCustomerSearch()).then((value) {
      _fetchMyData();
    });
  }

  @override
  void onInit() {
    posDataProvider.dashboardCallBack = this;
    desktopDataProvider.dashboardCallBack = this;
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

  _fetchCustomerListOff() {
    UINotification.showLoading();
    desktopDataProvider.getCusListOff();
    desktopDataProvider.getWarehouse();
    desktopDataProvider.getCusGrpOff();
    desktopDataProvider.getWarehouseProducts();
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

  @override
  onCustomerOffListDone(List<CustomerListOffResponse>? cListRes) {
    // cusList.value = cListRes;
    cache.setData(
        CacheDBPath.customers, cListRes?.map((e) => e.toJson()).toList());
    // selectedCustomerName.value = cListRes!.first.name.toString();
    UINotification.hideLoading();
  }

  @override
  onCustomerOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }

  @override
  onCustomerGrpOffListDone(List<CustomerGroupResponse>? cGrpRes) {
    cache.setData(
        CacheDBPath.customersGroup, cGrpRes?.map((e) => e.toJson()).toList());
    UINotification.hideLoading();
  }

  @override
  onCustomerGrpOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }

  @override
  onWProductOffListDone(List<WarehouseProductsResponse>? wPListRes) {
    cache.setData(CacheDBPath.warehouseProducts,
        wPListRes?.map((e) => e.toJson()).toList());
    UINotification.hideLoading();
  }

  @override
  onWProductOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }

  @override
  onWarehouseOffListDone(List<WarehouseListResponse>? wListRes) {
    cache.setData(
        CacheDBPath.warehouse, wListRes?.map((e) => e.toJson()).toList());
    UINotification.hideLoading();
  }

  @override
  onWarehouseOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }
}
