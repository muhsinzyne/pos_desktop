import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as form;

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/dashboard/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-expenses/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-order/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-sales/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/add-store/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/basket/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/complete-sale/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/products-for-orders/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/products-for-sales/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/sale-invoice/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/sales-payment/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/select-store/contracts.dart';
import 'package:posdelivery/app/modules/product_list/contracts.dart';
import 'package:posdelivery/app/modules/sales_point/contracts.dart';
import 'package:posdelivery/models/delivery/requests/expense_add_request.dart';
import 'package:posdelivery/models/delivery/requests/order_add_request.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/models/requests/customer/customer_add_request.dart';
import 'package:posdelivery/models/requests/pos/customer_list.dart';
import 'package:posdelivery/models/requests/pos/product_by_code.dart';
import 'package:posdelivery/models/requests/pos/product_list.dart';
import 'package:posdelivery/models/requests/pos/sale_request.dart';
import 'package:posdelivery/models/requests/pos/sale_view_request.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/customer/customer_price_group_response.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/add_sale_response.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
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

  //new design
  late INewSalesScreenController newSalesCtrl;
  late INewSalePaymentController newSalePaymentCtrl;
  late INewCompleteSaleScreenController newCompleteSaleCtrl;
  late INewStoreScreenController newStoreCtrl;
  late INewStoreAddScreenController newStoreAddCtrl;

  //delivery
  late IDeliverySalePaymentController deliverySalePaymentCtrl;
  late IDeliveryProductForSaleScreenController deliveryProductForSaleCtrl;
  late IDeliveryProductForOrderScreenController deliveryProductForOrderCtrl;
  late IDeliveryStoreAddController deliveryStoreAddCtrl;
  late IDeliveryExpenseAddController deliveryExpenseAddCtrl;
  late IDeliverySaleInvoiceScreenController deliverySaleInvoiceCtrl;
  late IDeliveryAddProductsOrderScreenController
      deliveryAddProductsOrderScreenCtrl;
  late IDeliveryAddProductsSaleScreenController
      deliveryAddProductsSaleScreenCtrl;
  late IDeliverySelectStoreController deliverySelectStoreCtrl;
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  //new design
  set newSalesCallBack(INewSalesScreenController controller) {
    newSalesCtrl = controller;
  }

  set newSalePaymentCallBack(INewSalePaymentController controller) {
    newSalePaymentCtrl = controller;
  }

  set newCompleteSaleCallBack(INewCompleteSaleScreenController controller) {
    newCompleteSaleCtrl = controller;
  }

  set newStoreCallBack(INewStoreScreenController controller) {
    newStoreCtrl = controller;
  }

  set newStoreAddCallBack(INewStoreAddScreenController controller) {
    newStoreAddCtrl = controller;
  }
  //

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

  set deliverySalePaymentCallBack(IDeliverySalePaymentController controller) {
    deliverySalePaymentCtrl = controller;
  }

  set deliverySelectStoreCallBack(IDeliverySelectStoreController controller) {
    deliverySelectStoreCtrl = controller;
  }

  set printCtrlCallBack(IDeliverySaleInvoiceScreenController controller) {
    deliverySaleInvoiceCtrl = controller;
  }

  customerAddRequest(CustomerAddRequest customerAddRequest) {
    final obs = network
        .post(NetworkURL.customerAdd, data: customerAddRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        CustomerAddResponse addResponse =
            CustomerAddResponse.fromJson(data.data);
        newStoreAddCtrl.onCustomerAddDone(addResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        newStoreAddCtrl.onCustomerAddError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        newStoreAddCtrl.onCustomerAddError(errMsg);
      }
    });
  }

  getCustomerList(CustomerListRequest customerListRequest) {
    final obs = network
        .get(NetworkURL.customerList,
            queryParameters: customerListRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        final List<CustomerListOffResponse> cListRes =
            customerListOffResponseFromJson(jsonEncode(data.data));
        newStoreCtrl.onCustomerListDone(cListRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        newStoreCtrl.onCustomerListError(errMsg);
        // print("404");
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        newStoreCtrl.onCustomerListError(errMsg);
        // print("400");
      }
    });
  }

  getStores() {
    final obs = network
        .get(
          NetworkURL.warehouseListOffline,
        )
        .asStream();
    obs.listen((data) {
      try {
        List<WarehouseListResponse> wRes =
            warehouseListResponseFromJson(jsonEncode(data.data));

        deliverySelectStoreCtrl.onWarehousetListDone(wRes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'warehouse_not_loaded'.tr;
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        deliverySelectStoreCtrl.onWarehousetListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        deliverySelectStoreCtrl.onWarehousetListError(errMsg);
      }
    });
  }

  //delivery
  getSaleInvoice(SaleViewRequest saleViewRequest) {
    final obs = network
        .get(NetworkURL.saleView, queryParameters: saleViewRequest.toJson())
        .asStream();
    obs.listen((data) {
      log(data.toString());
      try {
        InvoiceResponse invoiceResponse = InvoiceResponse.fromJson(data.data);
        newCompleteSaleCtrl.onSaleViewFetchDone(invoiceResponse);
        // deliverySaleInvoiceCtrl.onSaleViewFetchDone(invoiceResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        newCompleteSaleCtrl.onSaleViewError(errMsg);
        // deliverySaleInvoiceCtrl.onSaleViewError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        newCompleteSaleCtrl.onSaleViewError(errMsg);
      }
    });
  }

  saleOrderRequestOffline(SaleRequest saleRequest) {
    final obs =
        network.post(NetworkURL.addSale, data: saleRequest.toJson()).asStream();
    obs.listen((data) {
      try {
        AddSaleResponse addSaleResponse = AddSaleResponse.fromJSON(data.data);
        deliverySalePaymentCtrl.onSaleDoneOffline(addSaleResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        logger.e("error");
        errMsg.message = 'invalid_response'.tr;
        deliverySalePaymentCtrl.onSaleError(errMsg);
      }
    }, onError: (err) {
      logger.e("error 2");
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        deliverySalePaymentCtrl.onSaleError(errMsg);
      }
    });
  }

  saleOrderRequest(SaleRequest saleRequest) {
    final obs =
        network.post(NetworkURL.addSale, data: saleRequest.toJson()).asStream();
    obs.listen((data) {
      try {
        AddSaleResponse addSaleResponse = AddSaleResponse.fromJSON(data.data);
        newSalePaymentCtrl.onSaleDone(addSaleResponse);
        // deliverySalePaymentCtrl.onSaleDone(addSaleResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        logger.e("error");
        errMsg.message = 'invalid_response'.tr;
        newSalePaymentCtrl.onSaleError(errMsg);
        // deliverySalePaymentCtrl.onSaleError(errMsg);
      }
    }, onError: (err) {
      logger.e("error 2");
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        newSalePaymentCtrl.onSaleError(errMsg);
        // deliverySalePaymentCtrl.onSaleError(errMsg);
      }
    });
  }

  getSaleProductByCode(ProductByCodeRequest productByCodeRequest) {
    // final obs = network
    //     .get(NetworkURL.productByCode,
    //         queryParameters: productByCodeRequest.toJson())
    //     .asStream();
    // obs.listen((data) {
    //   try {
    //     Product product = Product.fromJson(data.data);
    //     deliveryAddProductsSaleScreenCtrl.onProductDone(product);
    //   } on Exception {
    //     final ErrorMessage errMsg = ErrorMessage();
    //     errMsg.message = 'warehouse_not_loaded'.tr;
    //   }
    // }, onError: (err) {
    //   final ErrorMessage errMsg =
    //       ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
    //   if (err.response.statusCode == StatusCodes.status404NotFound) {
    //     deliveryAddProductsSaleScreenCtrl.onProductError(errMsg);
    //   } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
    //     deliveryAddProductsSaleScreenCtrl.onProductError(errMsg);
    //   } else {
    //     deliveryAddProductsSaleScreenCtrl.onProductError(errMsg);
    //   }
    // });
  }

  getProductsSales(ProductListRequest productListRequest) {
    final obs = network
        .get(NetworkURL.products, queryParameters: productListRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        List<Product> product = productFromJson(jsonEncode(data.data));
        newSalesCtrl.onProductListDone(product);
        // deliveryProductForSaleCtrl.onProductListDone(product);
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
        newSalesCtrl.onProductListError(errMsg);
        // deliveryProductForOrderCtrl.onProductListError(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        logger.e("error 3");
        newSalesCtrl.onProductListError(errMsg);
        // deliveryProductForOrderCtrl.onProductListError(errMsg);
      } else {
        logger.e("error 4");
        newSalesCtrl.onProductListError(errMsg);
        // deliveryProductForOrderCtrl.onProductListError(errMsg);
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
    logger.w("hi");
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
}
