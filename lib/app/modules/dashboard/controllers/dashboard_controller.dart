import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as d;

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
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
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
import 'package:posdelivery/services/storage/app_storage_service.dart';
import 'package:sembast/sembast.dart';

class DashboardScreenController extends BaseGetXController
    implements IDashboardScreenController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  MyInfoResponse info = MyInfoResponse();
  DioNetwork network = Get.find<DioNetwork>();
  CacheService cache = Get.find<CacheService>();
  AppDatabase _db = Get.find<AppDatabase>();

  DesktopDataProvider desktopDataProvider = Get.find<DesktopDataProvider>();
  d.Dio dio = d.Dio();
  var cRegister = CurrentRegisterResponse().obs;
  var registerCloseSummary = RegisterCloseSummary().obs;
  List<Product> temp = [];

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

  _fetchCustomerListOff() {
    UINotification.showLoading();
    desktopDataProvider.getMyInfo();
    desktopDataProvider.getCustomerGroupAndPriceGroup();
    desktopDataProvider.getCusListOff();
    desktopDataProvider.getWarehouse();
    desktopDataProvider.getCusGrpOff();
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
    _getProducts();
  }

  _getProducts() async {
    for (var warehouse in info.warehouses!) {
      List<Product> temp = [];
      int currentPage = 1;
      Map<String, String> qp = {
        "warehouse_id": warehouse.id!,
        "page": "$currentPage",
        "limit": "10"
      };
      final pro = await getProduct(qp);
      /**
       * 
       */

      temp = productFromJson(jsonEncode(pro.data));
      print("\n \n \n \n -------------------------------------- \n \n \n \n");
      saveModel(temp);
      //print(temp[0].id);
      //print(temp[0]);
      // while (pro.data != []) {
      //   currentPage++;
      //   Map<String, String> _qp = {
      //     "warehouse_id": warehouse.id!,
      //     "page": "$currentPage",
      //     "limit": "100"
      //   };
      //   getProduct(_qp);
      // }
      //print(temp.length);
      //cache.setData(CacheDBPath.warehouseProducts + warehouse.id!,
      //  Iterable test = temp.map((e) => e.toJson().toList());
      //print(test);
    }
  }

  Future<List<Product>> saveModel(List<Product> item) async {
    StoreRef store = _db.getMapStore("products");
    Database? db = await _db.db;
    // await db?.transaction((transaction) async {
    //   item.map(
    //     (e) async => {await store.record(e.id).put(transaction, e.toJson())});
    //   if (item.id == null) {
    //   int key = await store.add(transaction, productToJson(item));
    //  item.id = key;
    //} else {
    // await store.record(item.id).put(transaction, item.toJson());
    //}
//    });

    await db?.transaction((transaction) async => {
          for (var i = 0; i < item.length; i++)
            {await store.add(transaction, item[i].toJson())}
          // Future.wait(
          // item.map((e) async => {
          //sasa
          // await store.add(transaction, e.toJson())
          // }),

          // await store.add(transaction, item[0].toJson())
        });
    print("\n \n \n \n \n hello \n \n \n\n ");
    return item;
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
