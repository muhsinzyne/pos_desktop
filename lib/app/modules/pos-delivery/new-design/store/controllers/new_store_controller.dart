import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/models/requests/pos/customer_list.dart';

class NewStoreScreenController extends BaseGetXController
    implements INewStoreScreenController {
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  //textcontroller
  final TextEditingController searchCtrl = TextEditingController();
  final logger = Logger();
  CustomerListOffResponse selectedStore = CustomerListOffResponse();
  RxList<CustomerListOffResponse> customerListTemp = RxList([]);
  RxList<CustomerListOffResponse> filteredcustomerList = RxList([]);
  CustomerListRequest customerListRequest = CustomerListRequest();

  void init() async {
    customerListRequest.limit = 100;
    customerListRequest.page = 1;
    deliveryDataProvider.getCustomerList(customerListRequest);
  }

  //lifecycle methods
  @override
  void onInit() async {
    Logger().wtf("messagje");
    deliveryDataProvider.newStoreCallBack = this;
    init();
    searchCtrl.addListener(() {
      List<CustomerListOffResponse> results = [];
      if (searchCtrl.text.isEmpty) {
        results = customerListTemp;
      } else {
        results = filteredcustomerList
            .where((product) => product.name!
                .toLowerCase()
                .contains(searchCtrl.text.toLowerCase()))
            .toList();
      }
      filteredcustomerList.value = results;
    });

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(milliseconds: 10));
    UINotification.showLoading();
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }

  //contracts
  @override
  onCustomerListDone(List<CustomerListOffResponse> cListRes) {
    customerListTemp.addAll(cListRes);
    filteredcustomerList.addAll(cListRes);
    if (cListRes.isNotEmpty) {
      customerListRequest.page = customerListRequest.page! + 1;
      deliveryDataProvider.getCustomerList(customerListRequest);
    } else {
      UINotification.hideLoading();
    }
  }

  @override
  onCustomerListError(ErrorMessage err) {
    // TODO: implement onCustomerListError
    throw UnimplementedError();
  }
}
