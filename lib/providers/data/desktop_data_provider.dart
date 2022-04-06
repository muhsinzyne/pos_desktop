import 'dart:convert';

import 'package:get/get.dart';
import 'package:posdelivery/app/modules/dashboard/contracts.dart';
import 'package:posdelivery/app/modules/product_list/contracts.dart';
import 'package:posdelivery/app/modules/sales_point/contracts.dart';
import 'package:posdelivery/models/requests/customer/customer_add_request.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/customer/customer_price_group_response.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/status_codes.dart';
import 'package:posdelivery/models/url.dart';
import 'package:posdelivery/providers/data/base_data_provider.dart';

import '../../models/response/desktop/customer_group.dart';
import '../../models/response/desktop/customer_list.dart';

class DesktopDataProvider extends BaseDataProvider {
  late ISalesPointController sPCtrl;
  late IProductListController pLCtrl;
  late IDashboardScreenController dashboardCtrl;

  set salePointCallBack(ISalesPointController controller) {
    sPCtrl = controller;
  }

  set productListCallBack(IProductListController controller) {
    pLCtrl = controller;
  }

  set dashboardCallBack(IDashboardScreenController controller) {
    dashboardCtrl = controller;
  }

  getCustomerGroupAndPriceGroup() {
    final obs = network
        .get(
          NetworkURL.customerAndPriceGroup,
        )
        .asStream();
    obs.listen((data) {
      try {
        CustomerPriceGroupsResponse customerPriceGroupsResponse =
            CustomerPriceGroupsResponse.fromJson(data.data);
        dashboardCtrl.customerGroupFetchDone(customerPriceGroupsResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;

        dashboardCtrl.onCustomerGroupFetchError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        //saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    });
  }

  getWarehouse() {
    final obs = network.get(NetworkURL.warehouseListOffline).asStream();
    obs.listen((data) {
      try {
        List<WarehouseListResponse> wRes =
            warehouseListResponseFromJson(jsonEncode(data.data));

        dashboardCtrl.onWarehouseOffListDone(wRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        dashboardCtrl.onWarehouseOffListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        dashboardCtrl.onWarehouseOffListError(errMsg);
      }
    });
  }

  getWarehouseProducts() {
    final obs = network.get(NetworkURL.warehouseProductOffline).asStream();
    obs.listen((data) {
      try {
        List<WarehouseProductsResponse> wPRes =
            warehouseProductsResponseFromJson(jsonEncode(data.data));
        dashboardCtrl.onWProductOffListDone(wPRes);
        // pLCtrl.onWProductOffListDone(wPRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        dashboardCtrl.onWProductOffListError(errMsg);
        // pLCtrl.onWProductOffListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        dashboardCtrl.onWProductOffListError(errMsg);
        // pLCtrl.onWProductOffListError(errMsg);
      }
    });
  }

  getCusListOff() {
    final obs = network.get(NetworkURL.customerListOffline).asStream();
    obs.listen((data) {
      try {
        List<CustomerListOffResponse> cListRes =
            customerListOffResponseFromJson(jsonEncode(data.data));
        dashboardCtrl.onCustomerOffListDone(cListRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        dashboardCtrl.onCustomerOffListError(errMsg);
        // print("404");
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        dashboardCtrl.onCustomerOffListError(errMsg);
        // print("400");
      }
    });
  }

  getCusGrpOff() {
    final obs = network.get(NetworkURL.customerGroupOffline).asStream();
    obs.listen((data) {
      try {
        List<CustomerGroupResponse> cGrpRes =
            customerGroupResponseFromJson(jsonEncode(data.data));
        dashboardCtrl.onCustomerGrpOffListDone(cGrpRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        dashboardCtrl.onCustomerGrpOffListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        dashboardCtrl.onCustomerGrpOffListError(errMsg);
      }
    });
  }

  getMyInfo() {
    final obs = network.get(NetworkURL.myInfo).asStream();
    obs.listen((data) {
      try {
        MyInfoResponse myInfoResponse = MyInfoResponse.fromJSON(data.data);
        dashboardCtrl.myInfoFetchDone(myInfoResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        dashboardCtrl.myInfoFetchError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        dashboardCtrl.myInfoFetchError(errMsg);
      }
    });
  }

  // getProducts() {
  //   Map<String, String> warehouseId = {"warehouse_id": "1"};
  //   final obs = network
  //       .get(NetworkURL.products, queryParameters: warehouseId)
  //       .asStream();
  //   obs.listen((data) {
  //     try {
  //       Product product = Product.fromJson(data.data);
  //       print("=====================================================");
  //       print(product);
  //       dashboardCtrl.productListFetchDone(product);
  //     } on Exception {
  //       final ErrorMessage errMsg = ErrorMessage();
  //       errMsg.message = 'warehouse_not_loaded'.tr;
  //     }
  //   }, onError: (err) {
  //     final ErrorMessage errMsg =
  //         ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
  //     if (err.response.statusCode == StatusCodes.status404NotFound) {
  //       dashboardCtrl.myInfoFetchError(errMsg);
  //     } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
  //       dashboardCtrl.myInfoFetchError(errMsg);
  //     }
  //   });
  // }

  customerAddRequest(CustomerAddRequest customerAddRequest) {
    final obs = network
        .post(NetworkURL.customerAdd, data: customerAddRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        CustomerAddResponse addResponse =
            CustomerAddResponse.fromJson(data.data);
        sPCtrl.onCustomerAddDone(addResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        sPCtrl.onCustomerAddError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        sPCtrl.onCustomerAddError(errMsg);
      }
    });
  }
}
