import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as d;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/dashboard/contracts.dart';
import 'package:posdelivery/app/modules/dashboard/views/find_customer_search.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/cache_db_path.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/requests/auth/register_close_summary_request.dart';
import 'package:posdelivery/models/requests/pos/customer_list.dart';
import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/response/customer/customer_data.dart';
import 'package:posdelivery/models/response/customer/customer_price_group_response.dart';
import 'package:posdelivery/models/response/desktop/customer_group.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/pos/warehouse.dart';
import 'package:posdelivery/models/url.dart';
import 'package:posdelivery/providers/data/desktop_data_provider.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/services/base/network.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/cache/cache_sembast_service.dart';
import 'package:posdelivery/services/storage/sembast_storage_service.dart';
import 'package:sembast/sembast.dart';

class DashboardScreenController extends BaseGetXController
    implements IDashboardScreenController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  MyInfoResponse info = MyInfoResponse();
  CustomerListRequest customerListRequest = CustomerListRequest();
  DioNetwork network = Get.find<DioNetwork>();
  CacheService cache = Get.find<CacheService>();
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  //SembastStorage _db = Get.find<SembastStorage>();
  CacheSembastService sembestCatch = Get.find<CacheSembastService>();

  DesktopDataProvider desktopDataProvider = Get.find<DesktopDataProvider>();
  d.Dio dio = d.Dio();
  var cRegister = CurrentRegisterResponse().obs;
  var registerCloseSummary = RegisterCloseSummary().obs;
  List<Product> temp = [];
  RxList<CustomerListOffResponse> customerListTemp = RxList([]);

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
    _fetchCustomerListOff();
  }

  actionPOSSalesWindowWithoutSync() {
    Get.back();
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

  _fetchCustomerListOff() async {
    UINotification.showLoading();
    desktopDataProvider.getMyInfo();
    desktopDataProvider.getCustomerGroupAndPriceGroup();
    desktopDataProvider.getWarehouse();
    desktopDataProvider.getCusGrpOff();
    desktopDataProvider.getCusListOff();
    desktopDataProvider.getWarehouseProducts();
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      _getMyInfo();
      Get.back();
      Get.toNamed(Routes.homePos);
      // UINotification.showLoading();
      // Future.delayed(const Duration(seconds: 2))
      //     .then((value) => UINotification.hideLoading());
    });
  }

  _getMyInfo() {
    final val = cache.getData(CacheDBPath.myInfo);
    info = MyInfoResponse.fromJSON(val);
//    _getProducts();
    //  _getCustomer();
    //   _getCustomerTest();
  }

  // _getCustomerTest() {
  //   int currentPage = 1;
  //   Map<String, String> queryCustomer = {
  //     "page": "$currentPage",
  //     "limit": "100"
  //   };
  //   desktopDataProvider.getCustomerListOff(queryCustomer);
  // }

  _getProducts() async {
    for (var warehouse in info.warehouses!) {
      dynamic pro;
      int currentPage = 1;
      Map<String, String> qp = {
        "warehouse_id": warehouse.id!,
        "page": "$currentPage",
        "limit": "100"
      };
      pro = await getProduct(qp);
      // while (pro.data != []) {
      //   currentPage++;
      //   qp = {
      //     "warehouse_id": warehouse.id!,
      //     "page": "$currentPage",
      //     "limit": "100"
      //   };
      //   pro = await getProduct(qp);
      // }

      for (var i = 0; i < temp.length; i++) {
        await sembestCatch.setProductData(
            Constants.warehouseProductsStore + warehouse.id.toString(),
            temp[i]);
        // await sembestCatch.setData( Constants.warehouseProductsStore + warehouse.id.toString(), temp[i]), "sasa"
      }
    }
  }

  Future<d.Response> getProduct(Map<String, String> qp) async {
    final val = await network.get(NetworkURL.products, queryParameters: qp);
    if (val.statusCode == 200 || val.statusCode == 201) {
      temp.addAll(productFromJson(jsonEncode(val.data)));
      return val;
    } else {
      return val;
    }
  }

  int currentPageCustomer = 1;
  late d.Response pro;
  _getCustomer() async {
    Map<String, String> queryCustomer = {
      "page": "$currentPageCustomer",
      "limit": "100"
    };
    pro = await getCustomer(queryCustomer);
    if (pro.data != []) {
      currentPageCustomer++;
      queryCustomer = {"page": "$currentPageCustomer", "limit": "100"};
      _getCustomer();
    } else {
      for (var i = 0; i < customerListTemp.length; i++) {
        await sembestCatch.setCustomerData(customerListTemp[i]);
      }
    }
    // while (pro.data != []) {
    //   currentPage++;
    //   queryCustomer = {"page": "$currentPage", "limit": "100"};
    //   pro = await getCustomer(queryCustomer);
    // }

    // for (var i = 0; i < customerListTemp.length; i++) {
    // await sembestCatch.setCustomerData(customerListTemp[i]);
    // }
  }

  Future<d.Response> getCustomer(Map<String, String> customerQuery) async {
    final val = await network.get(NetworkURL.customerListOffline,
        queryParameters: customerQuery);
    if (val.statusCode == 200 || val.statusCode == 201) {
      customerListTemp
          .addAll(customerListOffResponseFromJson(jsonEncode(val.data)));
      return val;
    } else {
      return val;
    }
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
  onCustomerOffListDone(List<CustomerListOffResponse> cListRes) {
    //logger.e(cListRes);
    //   logger.e(cListRes);
    // logger.e(customerListTemp);
    customerListTemp
        .addAll(customerListOffResponseFromJson(jsonEncode(cListRes)));
    //logger.w(customerListTemp);
    // logger.e(customerListTemp);
    // cache.setData( CacheDBPath.customers, cListRes?.map((e) => e.toJson()).toList());
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

  @override
  customerGroupFetchDone(CustomerPriceGroupsResponse response) {
    UINotification.hideLoading();

    cache.setData(CacheDBPath.customerPriceGroups, response);
  }

  @override
  onCustomerGroupFetchError(ErrorMessage err) {}

  @override
  myInfoFetchDone(MyInfoResponse myInfoResponse) {
    UINotification.hideLoading();
    cache.setData(CacheDBPath.myInfo, myInfoResponse.toJson());
    var _info = cache.getData(CacheDBPath.myInfo);
    info = MyInfoResponse.fromJSON(_info);
  }

  @override
  myInfoFetchError(ErrorMessage err) {
    UINotification.hideLoading();
  }
}
