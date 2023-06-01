import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/complete-sale/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/navigation/print_view_nav.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'dart:async';
import 'package:posdelivery/models/requests/pos/sale_view_request.dart';
import 'package:posdelivery/providers/local/pdf_invoice_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class NewCompleteSaleScreenController extends BaseGetXController
    implements INewCompleteSaleScreenController {
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  PrintViewNavParams? params;
  SaleViewRequest saleViewRequest = SaleViewRequest();
  Rx<InvoiceResponse> invoiceResponse = InvoiceResponse().obs;
  File? pdfFileTemp;
  RxBool isLoaded = false.obs;
  RxString pdfPath = "".obs;
  final Completer<PDFViewController> pdfController =
      Completer<PDFViewController>();
  _fetchInvoice() {
    // saleViewRequest.saleId = "220";
    saleViewRequest.saleId = params!.refId;
    deliveryDataProvider.getSaleInvoice(saleViewRequest);
  }

  test() {
    Logger().e("message");
  }

  downloadPDF() async {
    pdfFileTemp = await PdfInvoiceProvider.generate(invoiceResponse.value);
    pdfPath.value = pdfFileTemp!.path;
    isLoaded.value = true;
    // PdfInvoiceProvider.openFile(pffFile);
    // UINotification.hideLoading();
  }

//lifecycles
  @override
  void onInit() {
    deliveryDataProvider.newCompleteSaleCallBack = this;
    params = Get.arguments;

    if (params?.refId != null) {
      _fetchInvoice();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(milliseconds: 10));
    UINotification.showLoading();
  }

  @override
  void onClose() {}

//contracts
  @override
  onSaleViewError(ErrorMessage errorMessage) {
    Get.snackbar("failed", errorMessage.message ?? "Something went wrong");
  }

  @override
  onSaleViewFetchDone(InvoiceResponse response) {
    UINotification.hideLoading();
    invoiceResponse.value = response;
    downloadPDF();
  }
}
