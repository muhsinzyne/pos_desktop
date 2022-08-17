import 'dart:convert';
import 'package:dio/dio.dart' as form;

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/dashboard/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-expenses/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-order/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-sales/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/products-for-orders/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/products-for-sales/contracts.dart';
import 'package:posdelivery/app/modules/product_list/contracts.dart';
import 'package:posdelivery/app/modules/sales_point/contracts.dart';
import 'package:posdelivery/models/delivery/requests/expense_add_request.dart';
import 'package:posdelivery/models/delivery/requests/order_add_request.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/delivery/response/expense_add_response.dart';
import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/models/requests/customer/customer_add_request.dart';
import 'package:posdelivery/models/requests/pos/customer_list.dart';
import 'package:posdelivery/models/requests/pos/product_by_code.dart';
import 'package:posdelivery/models/requests/pos/product_list.dart';
import 'package:posdelivery/models/requests/pos/warehouse_products.dart';
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

class DeliveryDataProvider extends BaseDataProvider {
  late ISalesPointController sPCtrl;
  late IProductListController pLCtrl;
  // late IStoreAddController cAddCtrl;
  late IDashboardScreenController dashboardCtrl;

  //delivery
  late IDeliveryProductForSaleScreenController deliveryProductForSaleCtrl;
  late IDeliveryProductForOrderScreenController deliveryProductForOrderCtrl;
  late IDeliveryStoreAddController deliveryStoreAddCtrl;
  late IDeliveryExpenseAddController deliveryExpenseAddCtrl;
  late IDeliveryAddProductsOrderScreenController
      deliveryAddProductsOrderScreenCtrl;
  late IDeliveryAddProductsSaleScreenController
      deliveryAddProductsSaleScreenCtrl;
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  set salePointCallBack(ISalesPointController controller) {
    sPCtrl = controller;
  }

  set productListCallBack(IProductListController controller) {
    pLCtrl = controller;
  }

  set dashboardCallBack(IDashboardScreenController controller) {
    dashboardCtrl = controller;
  }

  //delivery
  set deliveryAddProductsOrderCallBack(
      IDeliveryAddProductsOrderScreenController controller) {
    deliveryAddProductsOrderScreenCtrl = controller;
  }

  set deliveryAddProductsSaleCallBack(
      IDeliveryAddProductsSaleScreenController controller) {
    deliveryAddProductsSaleScreenCtrl = controller;
  }

  set deliveryProductForSaleCallBack(
      IDeliveryProductForSaleScreenController controller) {
    deliveryProductForSaleCtrl = controller;
  }

  set deliveryProductForOrderCallBack(
      IDeliveryProductForOrderScreenController controller) {
    deliveryProductForOrderCtrl = controller;
  }

  set deliveryStoreAddCallBack(IDeliveryStoreAddController controller) {
    deliveryStoreAddCtrl = controller;
  }

  set deliveryExpenseAddCallBack(IDeliveryExpenseAddController controller) {
    deliveryExpenseAddCtrl = controller;
  }

  //delivery
  getSaleProductByCode(ProductByCodeRequest productByCodeRequest) {
    final obs = network
        .get(NetworkURL.productByCode,
            queryParameters: productByCodeRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        Product product = Product.fromJson(data.data);
        deliveryAddProductsSaleScreenCtrl.onProductDone(product);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        deliveryAddProductsSaleScreenCtrl.onProductError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        deliveryAddProductsSaleScreenCtrl.onProductError(errMsg);
      } else {
        deliveryAddProductsSaleScreenCtrl.onProductError(errMsg);
      }
    });
  }

  getProductsSales(ProductListRequest productListRequest) {
    final obs = network
        .get(NetworkURL.products, queryParameters: productListRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        List<Product> product = productFromJson(jsonEncode(data.data));
        deliveryProductForSaleCtrl.onProductListDone(product);
      } on Exception {
        logger.wtf("error 1");
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      logger.wtf("error 2");
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        deliveryProductForOrderCtrl.onProductListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        logger.e("error 3");
        deliveryProductForSaleCtrl.onProductListError(errMsg);
      } else {
        logger.e("error 4");
        deliveryProductForSaleCtrl.onProductListError(errMsg);
      }
    });
  }

  getProductByCode(ProductByCodeRequest productByCodeRequest) {
    final obs = network
        .get(NetworkURL.productByCode,
            queryParameters: productByCodeRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        Product product = Product.fromJson(data.data);
        deliveryAddProductsOrderScreenCtrl.onProductDone(product);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        deliveryAddProductsOrderScreenCtrl.onProductError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        deliveryAddProductsOrderScreenCtrl.onProductError(errMsg);
      } else {
        deliveryProductForOrderCtrl.onProductListError(errMsg);
      }
    });
  }

  //api not avalable in production
  orderAddRequest(OrderAddRequest orderAddRequest) {
    final obs = network
        .post(
          "http://test.pos.local/api/offline/add_order",
          data: orderAddRequest.toJson(),
        )
        .asStream();
    obs.listen((data) {
      try {
        // StoreAddResponse addResponse = StoreAddResponse.fromJson(data.data);
        logger.w(data.data);
        // logger.w(data.data);
        // cAddCtrlonCustomerAddDone(addResponse);

      } catch (msg) {
        logger.e("error");
        logger.e(msg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      logger.e("exception");
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        // cAddCtrl.onCustomerAddError(errMsg);
      }
    });
  }

  getProducts(ProductListRequest productListRequest) {
    final obs = network
        .get(NetworkURL.products, queryParameters: productListRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        List<Product> product = productFromJson(jsonEncode(data.data));
        deliveryProductForOrderCtrl.onProductListDone(product);
      } on Exception {
        logger.wtf("error 1");
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      logger.wtf("error 2");
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        deliveryProductForOrderCtrl.onProductListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        logger.e("error 3");
        deliveryProductForOrderCtrl.onProductListError(errMsg);
      } else {
        logger.e("error 4");
        deliveryProductForOrderCtrl.onProductListError(errMsg);
      }
    });
  }

  //api not avalable in production
  //only worrks when sending as formdata.. error when sending as json don't know why!!
  expenseAddRequestWithoutFile(ExpenseAddRequest expenseAddRequest) async {
    var formData = form.FormData.fromMap({
      'amount': expenseAddRequest.amount,
      'note': expenseAddRequest.note,
      'category_id': expenseAddRequest.category_id,
      'reference': expenseAddRequest.reference,
      'warehouse_id': expenseAddRequest.warehouse_id,
    });
    final obs = network
        .upload(
          "http://test.pos.local/api/offline/add_expense",
          data: formData,
        )
        .asStream();
    obs.listen((data) {
      try {
        logger.w(data.data);
        logger.e("worked");
      } catch (msg) {
        logger.e("error");
        logger.e(msg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      logger.e("exception");
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        // cAddCtrl.onCustomerAddError(errMsg);
      }
    });
  }

  //api not avalable in production
  expenseAddRequest(dynamic formData) async {
    final obs = network
        .upload(
          "http://test.pos.local/api/offline/add_expense",
          data: formData,
        )
        .asStream();
    obs.listen((data) {
      try {
        // StoreAddResponse addResponse = StoreAddResponse.fromJson(data.data);
        logger.w(data.data);
        // logger.w(data.data);
        // cAddCtrl.onCustomerAddDone(addResponse);

      } catch (msg) {
        logger.e("error");
        logger.e(msg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      logger.e("exception");
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        // cAddCtrl.onCustomerAddError(errMsg);
      }
    });
  }

  //api not avalable in production
  storeAddRequest(StoreAddRequest storeAddRequest) {
    final obs = network
        .post(
          "http://test.pos.local/api/offline/add_store",
          data: storeAddRequest.toJson(),
        )
        .asStream();
    logger.w("?");
    obs.listen((data) {
      try {
        StoreAddResponse addResponse = StoreAddResponse.fromJson(data.data);
        logger.e("worked");
        // logger.w(data.data);
        deliveryStoreAddCtrl.onStoreAddDone(addResponse);
      } catch (msg) {
        logger.e("error");
        logger.e(msg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      logger.e("exception");
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        deliveryStoreAddCtrl.onStoreAddError(errMsg);
      }
    });
  }

  ///----------------------

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

  getCusListOff(CustomerListRequest customerListRequest) {
    final obs = network
        .get(NetworkURL.customerListOffline,
            queryParameters: customerListRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        final List<CustomerListOffResponse> cListRes =
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
