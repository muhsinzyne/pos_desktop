import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales-list/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/requests/pos/sale_view_request.dart';
import 'package:posdelivery/models/requests/pos/sales_list_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/models/response/pos/sales_list.dart';
import 'package:posdelivery/models/response/pos/sales_list_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/providers/local/pdf_invoice_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/location_service.dart';
import 'dart:async';

class NewSalesListScreenController extends BaseGetXController
    implements INewSalesListScreenController {
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  //textcontroller
  final TextEditingController searchCtrl = TextEditingController();
  final logger = Logger();
  File? pdfFile;
  RxList<SalesInfoShort> salesListTemp = RxList([]);
  RxList<SalesInfoShort> filteredSalesList = RxList([]);
  SalesListRequest salesListRequest = SalesListRequest();
  SaleViewRequest saleViewRequest = SaleViewRequest();
  void init() async {
    salesListRequest.limit = 100;
    salesListRequest.page = 1;
    deliveryDataProvider.getSalesList(salesListRequest);
  }

  fetchInvoice(String refId ) async {
    UINotification.showLoading();
    saleViewRequest.saleId = refId;
    deliveryDataProvider.getInvoice(saleViewRequest);
  }

  //lifecycle methods
  @override
  void onInit() async {
    Logger().wtf("messagje");

    deliveryDataProvider.newSalesListCallBack = this;
    init();
    searchCtrl.addListener(() {
      List<SalesInfoShort> results = [];
      if (searchCtrl.text.isEmpty) {
        results = salesListTemp;
      } else {
        results = filteredSalesList
            .where((sale) => sale.customer!
                .toLowerCase()
                .contains(searchCtrl.text.toLowerCase()))
            .toList();
      }
      filteredSalesList.value = results;
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
  onCustomerListError(ErrorMessage err) {
    // TODO: implement onCustomerListError
    throw UnimplementedError();
  }

  @override
  onSalesListResponseDone(SalesListResponse salesListResponse) {
    UINotification.hideLoading();
    Logger().w(salesListResponse.sales![0].referenceNo);
    salesListTemp.addAll(salesListResponse.sales ?? []);
    filteredSalesList.addAll(salesListResponse.sales ?? []);
    // if (salesListResponse.sales!.isNotEmpty) {
    // salesListRequest.page = salesListRequest.page + 1;
    // deliveryDataProvider.getSalesList(salesListRequest);
    // } else {

    // }
  }

  @override
  onSalesListResponseError(ErrorMessage err) {
    Logger().e("erro");
  }

  @override
  onSaleViewError(ErrorMessage errorMessage) {
    // TODO: implement onSaleViewError
    throw UnimplementedError();
  }

  @override
  onSaleViewFetchDone(InvoiceResponse invoiceResponse) async {
    pdfFile = await PdfInvoiceProvider.generate(invoiceResponse);

    PdfInvoiceProvider.openFile(pdfFile!);
    UINotification.hideLoading();
  }
}
