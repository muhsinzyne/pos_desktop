import 'dart:convert';

import 'package:get/get.dart';
import 'package:posdelivery/app/modules/product_list/contracts.dart';
import 'package:posdelivery/app/modules/sales_point/contracts.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/status_codes.dart';
import 'package:posdelivery/models/url.dart';
import 'package:posdelivery/providers/data/base_data_provider.dart';

import '../../models/response/desktop/customer_group.dart';
import '../../models/response/desktop/customer_list.dart';

class DesktopDataProvider extends BaseDataProvider {
  late ISalesPointController sPCtrl;
  late IProductListController pLCtrl;

  set salePointCallBack(ISalesPointController controller) {
    sPCtrl = controller;
  }

  set productListCallBack(IProductListController controller) {
    pLCtrl = controller;
  }

  getWarehouse() {
    final obs = network.get(NetworkURL.warehouseListOffline).asStream();
    obs.listen((data) {
      try {
        List<WarehouseListResponse> wRes =
            warehouseListResponseFromJson(jsonEncode(data.data));

        sPCtrl.onWarehouseOffListDone(wRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        sPCtrl.onWarehouseOffListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        sPCtrl.onWarehouseOffListError(errMsg);
      }
    });
  }

  getWarehouseProducts() {
    final obs = network.get(NetworkURL.warehouseProductOffline).asStream();
    obs.listen((data) {
      try {
        List<WarehouseProductsResponse> wPRes =
            warehouseProductsResponseFromJson(jsonEncode(data.data));
        sPCtrl.onWProductOffListDone(wPRes);
        pLCtrl.onWProductOffListDone(wPRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        sPCtrl.onWProductOffListError(errMsg);
        pLCtrl.onWProductOffListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        sPCtrl.onWProductOffListError(errMsg);
        pLCtrl.onWProductOffListError(errMsg);
      }
    });
  }

  getCusListOff() {
    final obs = network.get(NetworkURL.customerListOffline).asStream();
    obs.listen((data) {
      try {
        List<CustomerListOffResponse> cListRes =
            customerListOffResponseFromJson(jsonEncode(data.data));
        sPCtrl.onCustomerOffListDone(cListRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        sPCtrl.onCustomerOffListError(errMsg);
        // print("404");
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        sPCtrl.onCustomerOffListError(errMsg);
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
        sPCtrl.onCustomerGrpOffListDone(cGrpRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        sPCtrl.onCustomerGrpOffListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        sPCtrl.onCustomerGrpOffListError(errMsg);
      }
    });
  }
}
