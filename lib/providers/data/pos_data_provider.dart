import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:posdelivery/app/modules/auth/contracts.dart';
import 'package:posdelivery/app/modules/contracts.dart';
import 'package:posdelivery/app/modules/crud/contracts.dart';
import 'package:posdelivery/app/modules/dashboard/contracts.dart';
import 'package:posdelivery/app/modules/payment/contracts.dart';
import 'package:posdelivery/app/modules/pos/contract.dart';
import 'package:posdelivery/app/modules/pos/print-view/contracts.dart';
import 'package:posdelivery/app/modules/sales_point/contracts.dart';
import 'package:posdelivery/models/requests/auth/open_register_request.dart';
import 'package:posdelivery/models/requests/auth/register_close_summary_request.dart';
import 'package:posdelivery/models/requests/customer/customer_add_request.dart';
import 'package:posdelivery/models/requests/customer/customer_list_request.dart';
import 'package:posdelivery/models/requests/customer/customer_search_request.dart';
import 'package:posdelivery/models/requests/payment/add_sale_payment_request.dart';
import 'package:posdelivery/models/requests/pos/customer_list.dart';
import 'package:posdelivery/models/requests/pos/product_suggestion.dart';
import 'package:posdelivery/models/requests/pos/sale_request.dart';
import 'package:posdelivery/models/requests/pos/sale_view_request.dart';
import 'package:posdelivery/models/requests/pos/sales_list_request.dart';
import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/auth/open_register_response.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/response/customer/customer_account_list_response.dart';
import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/message.dart';
import 'package:posdelivery/models/response/pos/add_sale_response.dart';
import 'package:posdelivery/models/response/pos/customer_list_response.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/models/response/pos/product_suggestion_response.dart';
import 'package:posdelivery/models/response/pos/sales_list_response.dart';
import 'package:posdelivery/models/status_codes.dart';
import 'package:posdelivery/models/url.dart';
import 'package:posdelivery/providers/data/base_data_provider.dart';
import 'package:posdelivery/services/app_service.dart';

import '../../models/response/customer/customer_price_group_response.dart';

class PosDataProvider extends BaseDataProvider {
  AppService appService = Get.find<AppService>();
  late ISalesListScreenController saleListCtrl;
  late IBaseGetXController bCtrl;
  late IFindCustomerScreenController iFindCCtrl;
  late IProductSuggestionController pSujCtrl;
  late IPosPaymentController posPaymentCtrl;
  late IPrintScreenController printCtrl;
  late ICustomerAddController cAddCtrl;
  late ICustomerListController cListCtrl;
  late ISalePaymentController salePaymentCtrl;
  late IDashboardScreenController dashboardCtrl;
  late IOpenRegisterController openRegisterCtrl;

  set callBack(IBaseGetXController controller) {
    bCtrl = controller;
  }

  set salePaymentCallBack(ISalePaymentController controller) {
    salePaymentCtrl = controller;
  }

  set customerListCalBack(ICustomerListController controller) {
    cListCtrl = controller;
  }

  set printCtrlCallBack(IPrintScreenController controller) {
    printCtrl = controller;
  }

  set pSujCallBack(IProductSuggestionController controller) {
    pSujCtrl = controller;
  }

  set findCustomerCallBack(IFindCustomerScreenController controller) {
    iFindCCtrl = controller;
  }

  set salesListCallBack(ISalesListScreenController controller) {
    saleListCtrl = controller;
  }

  set posPaymentCallBack(IPosPaymentController controller) {
    posPaymentCtrl = controller;
  }

  set customerAddCtrlBack(ICustomerAddController controller) {
    cAddCtrl = controller;
  }

  set dashboardCallBack(IDashboardScreenController controller) {
    dashboardCtrl = controller;
  }

  set openRegisterCallBack(IOpenRegisterController controller) {
    openRegisterCtrl = controller;
  }

  openRegister(OpenRegisterRequest opRequest) {
    final obs = network
        .post(NetworkURL.openRegister, data: opRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        OpenRegisterResponse opResponse =
            OpenRegisterResponse.fromJSON(data.data);
        openRegisterCtrl.onOpenRegisterDone(opResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'could_not_open_your_register'.tr;
        openRegisterCtrl.onOpenRegisterError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        openRegisterCtrl.onOpenRegisterError(errMsg);
      } else if (err.response?.statusCode == StatusCodes.status404NotFound) {
        openRegisterCtrl.onOpenRegisterError(errMsg);
      }
    });
  }

  registerCloseSummaryForDashBoard(RegisterCloseSummaryRequest rReq) {
    final obs = network
        .get(NetworkURL.registerCloseSummary, queryParameters: rReq.toJson())
        .asStream();
    obs.listen((data) {
      try {
        RegisterCloseSummary rSummary =
            RegisterCloseSummary.fromJson(data.data);
        dashboardCtrl.onRegisterCloseSummaryDone(rSummary);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'register_not_opened'.tr;
        dashboardCtrl.onRegisterCloseSummaryError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response.statusCode == StatusCodes.status404NotFound) {
        dashboardCtrl.onCurrentRegisterNotOpen(errMsg);
      } else if (err.response.statusCode == StatusCodes.status400BadRequest) {
        //saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    });
  }

  myRegisterSummary() {
    final obs = network
        .get(
          NetworkURL.myRegisterSummary,
        )
        .asStream();
    obs.listen((data) {
      try {
        CurrentRegisterResponse cResponse =
            CurrentRegisterResponse.fromJson(data.data);
        dashboardCtrl.onCurrentRegisterResponseDone(cResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'register_not_opened'.tr;
        dashboardCtrl.onCurrentRegisterNotOpen(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status404NotFound) {
        dashboardCtrl.onCurrentRegisterNotOpen(errMsg);
      } else if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        //saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    });
  }

  addSalePayment(AddSalePaymentRequest addSalePaymentRequest) {
    final obs = network
        .post(NetworkURL.addSalePayment,
            data: addSalePaymentRequest.toJson(),
            queryParameters: addSalePaymentRequest.urlParams())
        .asStream();
    obs.listen((data) {
      try {
        CommonMessage cMes = CommonMessage.fromJSON(data.data);
        salePaymentCtrl.onSalePaymentDone(cMes);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        salePaymentCtrl.onSalePaymentError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        salePaymentCtrl.onSalePaymentError(errMsg);
      } else if (err.response?.statusCode == StatusCodes.status404NotFound) {
        salePaymentCtrl.onSalePaymentError(errMsg);
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
        cAddCtrl.onCustomerAddDone(addResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        cAddCtrl.onCustomerAddError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        cAddCtrl.onCustomerAddError(errMsg);
      }
    });
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
        cAddCtrl.customerGroupFetchDone(customerPriceGroupsResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        cAddCtrl.onCustomerGroupFetchError(errMsg);
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

  getSaleInvoice(SaleViewRequest saleViewRequest) {
    final obs = network
        .get(NetworkURL.saleView, queryParameters: saleViewRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        InvoiceResponse invoiceResponse = InvoiceResponse.fromJson(data.data);
        printCtrl.onSaleViewFetchDone(invoiceResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        printCtrl.onSaleViewError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        //saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    });
  }

  saleOrderRequest(SaleRequest saleRequest) {
    final obs =
        network.post(NetworkURL.addSale, data: saleRequest.toJson()).asStream();
    obs.listen((data) {
      try {
        AddSaleResponse addSaleResponse = AddSaleResponse.fromJSON(data.data);
        posPaymentCtrl.onSaleDone(addSaleResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        posPaymentCtrl.onSaleError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        //saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    });
  }

  getProductSuggestion(String term) {
    ProductSuggestionRequest pSugReq = ProductSuggestionRequest();
    pSugReq.term = term;
    pSugReq.warehouseId = appService.myInfoResponse.warehouseId;

    final obs = network
        .get(NetworkURL.productSuj, queryParameters: pSugReq.toJson())
        .asStream();
    obs.listen((data) {
      try {
        ProductSuggestionResponse pResponse =
            ProductSuggestionResponse.fromJSON(data.data);
        pSujCtrl.onSuggestionDone(pResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        pSujCtrl.onSuggestionError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        //saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    });
  }

  getCustomerSearch(String term) {
    CustomerSearchRequest pSugReq = CustomerSearchRequest();
    pSugReq.term = term;

    final obs = network
        .get(NetworkURL.customerSearch, queryParameters: pSugReq.toJson())
        .asStream();
    obs.listen((data) {
      try {
        CustomerListResponse customerListResponse =
            CustomerListResponse.fromJSON(data.data);
        pSujCtrl.onCustomerSuggestionDone(customerListResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        pSujCtrl.onCustomerSuggestionError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        //saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    });
  }

  getAllCustomerList() {
    CustomerListRequest cList = CustomerListRequest();
    cList.type = 'all';

    final obs = network
        .get(NetworkURL.allCustomerList, queryParameters: cList.toJson())
        .asStream();
    obs.listen((data) {
      print(data);
      try {
        CustomerListResponse cListResponse =
            CustomerListResponse.fromJSON(data.data);

        iFindCCtrl.onCustomerListDone(cListResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;

        iFindCCtrl.onCustomerListError(errMsg);
      }
    }, onError: (err) {
      print("on error called");
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        //saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    });
  }

  getSalesList(SalesListRequest salesListRequest) {
    final obs = network
        .get(NetworkURL.salesList, queryParameters: salesListRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        SalesListResponse salesListResponse =
            SalesListResponse.fromJSON(data.data);
        saleListCtrl.onSalesListResponseDone(salesListResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        saleListCtrl.onSalesListResponseBadRequest(errMsg);
      }
    });
  }

  getCustomerListRequest(CustomerAccountListRequest cRequest) {
    final obs = network
        .get(NetworkURL.customerList, queryParameters: cRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        CustomerAccountListResponse cAccResponse =
            CustomerAccountListResponse.fromJSON(data.data);
        cListCtrl.onCustomerListFetchDone(cAccResponse);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'invalid_response'.tr;
        cListCtrl.onCustomerListFetchError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        cListCtrl.onCustomerListFetchError(errMsg);
      }
    });
  }
}
