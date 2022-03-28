import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/crud/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/navigation/sales_list_nav.dart';
import 'package:posdelivery/models/requests/customer/customer_list_request.dart';
import 'package:posdelivery/models/response/customer/customer_account_list_response.dart';
import 'package:posdelivery/models/response/customer/customer_data.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

class CustomerListController extends BaseGetXController
    implements ICustomerListController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  CustomerAccountListRequest customerListRequest = CustomerAccountListRequest();
  ScrollController scrollCtrl = ScrollController();

  RxList<CustomerData> customerList = RxList([]);

  @override
  void onInit() {
    isLoading.value = true;
    customerListRequest.page = 1;
    customerListRequest.limit = 10;
    posDataProvider.customerListCalBack = this;
    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels == scrollCtrl.position.maxScrollExtent) {
        print("max scroll extended");
        _loadMore();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    _fetchListData();
    super.onReady();
  }

  actionOnSalesList(CustomerData customerData) {
    SalesListNavParams salesListNavParams = SalesListNavParams();
    salesListNavParams.customerId = customerData.id;
    salesListNavParams.customerName = customerData.company;
    Get.toNamed(Routes.salesList, arguments: salesListNavParams);
  }

  _loadMore() async {
    if (isLoading.isFalse) {
      customerListRequest.page++;
      isLoading.value = true;
      posDataProvider.getCustomerListRequest(customerListRequest);
    } else {
      // loading already
    }
  }

  _fetchListData() {
    UINotification.showLoading();
    posDataProvider.getCustomerListRequest(customerListRequest);
  }

  @override
  onCustomerListFetchDone(CustomerAccountListResponse customerListResponse) {
    UINotification.hideLoading();
    isLoading.value = false;
    if ((customerListResponse.customerList?.length ?? 0) > 0) {
      isLoading.value = false;
      customerList.value = [customerList, customerListResponse.customerList!]
          .expand((x) => x)
          .toList();
    }
  }

  @override
  onCustomerListFetchError(ErrorMessage err) {
    UINotification.hideLoading();
    isLoading.value = false;
  }
}
