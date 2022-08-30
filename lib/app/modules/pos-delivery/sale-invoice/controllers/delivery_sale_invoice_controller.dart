import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/sale-invoice/contracts.dart';
import 'package:posdelivery/app/modules/pos/print-view/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/navigation/print_view_nav.dart';
import 'package:posdelivery/models/requests/pos/sale_view_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/providers/local/pdf_invoice_provider.dart';
import 'package:posdelivery/providers/local/pdf_small_invoice_provider.dart';
import 'package:posdelivery/providers/local/print_provider.dart';

class DeliverySaleInvoiceScreenController extends BaseGetXController
    implements IDeliverySaleInvoiceScreenController {
  PrintProvider printProvider = Get.find<PrintProvider>();
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();

  PrintViewNavParams? params;
  Rx<InvoiceResponse> invoiceResponse = InvoiceResponse().obs;

  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  // List<Employee> employees = <Employee>[];

  // late EmployeeDataSource employeeDataSource;
  @override
  void onInit() {
    // deliveryDataProvider.deliverySaleInvoiceCtrl = this;
    // params = Get.arguments;
    // if (params!.refId != null) {
    _fetchInvoice();
    // }

    super.onInit();
  }

  _fetchInvoice() {
    SaleViewRequest saleViewRequest = SaleViewRequest();
    // saleViewRequest.saleId = params!.refId;
    saleViewRequest.saleId = "174";
    deliveryDataProvider.getSaleInvoice(saleViewRequest);
  }

  @override
  void onReady() {
    UINotification.showLoading();
    logger.wtf("message");
    super.onReady();
  }

  @override
  onSaleViewError(ErrorMessage errorMessage) {
    UINotification.hideLoading();
    print(errorMessage);
  }

  @override
  onSaleViewFetchDone(InvoiceResponse dataResponse) {
    isLoading.value = false;
    UINotification.hideLoading();
    invoiceResponse.value = dataResponse;
    logger.e(invoiceResponse.value.getQrCodeWidgetImage());
    print(invoiceResponse.toJson());
  }

  @override
  actionOnPrint() async {
    UINotification.showLoading();
    // printProvider.loadImage(invoiceResponse.value.logoPath);
    // PdfInvoiceProvider.loadImage(invoiceResponse.value.logoPath);
    await Future.delayed(Constants.smallDuration);
    final pffFile =
        await PdfSmallInvoiceProvider.generate(invoiceResponse.value);
    PdfSmallInvoiceProvider.openFile(pffFile);

    // printProvider.printPosInvoice(invoiceResponse.value);

    UINotification.hideLoading();
  }
}
// }