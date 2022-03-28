import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/navigation/print_view_nav.dart';
import 'package:posdelivery/models/navigation/sale_payment_nav.dart';
import 'package:posdelivery/models/navigation/sales_list_nav.dart';
import 'package:posdelivery/models/requests/pos/sales_list_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/sales_list.dart';
import 'package:posdelivery/models/response/pos/sales_list_response.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

import '../../contract.dart';

class SalesListScreenController extends BaseGetXController
    implements ISalesListScreenController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  RxList<SalesInfoShort> salesList = RxList([]);
  SalesListRequest salesListRequest = SalesListRequest();
  ScrollController scrollCtrl = ScrollController();
  var navParams = SalesListNavParams().obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      navParams.value = Get.arguments;
      if (navParams.value.customerId != null) {
        salesListRequest.customerId = navParams.value.customerId;
      }
    }
    isLoading.value = true;
    posDataProvider.saleListCtrl = this;
    salesListRequest.page = 1;
    salesListRequest.limit = 10;
    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels == scrollCtrl.position.maxScrollExtent) {
        print("max scroll extended");
        _loadMore();
      }
    });
    super.onInit();
  }

  actionOnAddPayment(SalesInfoShort salesInfoShort) {
    SalePaymentNavParams sParams = SalePaymentNavParams();
    sParams.id = salesInfoShort.id;
    sParams.customer = salesInfoShort.customer;
    sParams.referenceNo = salesInfoShort.referenceNo;
    sParams.paid = salesInfoShort.paid;
    sParams.balance = salesInfoShort.balance;
    sParams.saleStatus = salesInfoShort.saleStatus;
    sParams.paymentStatus = salesInfoShort.paymentStatus;
    Get.toNamed(Routes.salePayment, arguments: sParams)?.then((value) {
      _pageRefresh();
    });
  }

  actionOnInvoiceView(SalesInfoShort salesInfoShort) {
    PrintViewNavParams params = PrintViewNavParams();
    params.refId = salesInfoShort.id;
    Get.toNamed(Routes.printView, arguments: params);
  }

  _pageRefresh() {
    UINotification.showLoading();
    salesList.clear();
    salesListRequest.page = 1;
    isLoading.value = true;
    posDataProvider.getSalesList(salesListRequest);
  }

  @override
  void onReady() {
    UINotification.showLoading();
    isLoading.value = true;
    posDataProvider.getSalesList(salesListRequest);
    _scrollPageLoad();
    super.onReady();
  }

  @override
  onSalesListResponseDone(SalesListResponse salesListResponse) {
    UINotification.hideLoading();
    isLoading.value = false;
    if ((salesListResponse.sales?.length ?? 0) > 0) {
      isLoading.value = false;
      salesList.value =
          [salesList, salesListResponse.sales!].expand((x) => x).toList();
    }
  }

  @override
  onSalesListResponseBadRequest(ErrorMessage errorMessage) {
    UINotification.hideLoading();
    isLoading.value = false;
    //throw UnimplementedError();
  }

  _loadMore() async {
    if (isLoading.isFalse) {
      salesListRequest.page++;
      isLoading.value = true;
      posDataProvider.getSalesList(salesListRequest);
    } else {
      // loading already
    }
  }

  _scrollPageLoad() {}
}
