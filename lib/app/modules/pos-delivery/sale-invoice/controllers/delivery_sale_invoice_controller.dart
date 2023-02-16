import 'dart:developer';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/sale-invoice/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/navigation/print_view_nav.dart';
import 'package:posdelivery/models/requests/pos/sale_view_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/providers/local/blue_thermal_print_provider.dart';
import 'package:posdelivery/providers/local/pdf_invoice_provider.dart';
import 'package:posdelivery/providers/local/print_provider.dart';
import 'dart:async';

class DeliverySaleInvoiceScreenController extends BaseGetXController
    implements IDeliverySaleInvoiceScreenController {
  BlueThermalPrinterProdvider blueThermalPrinterProdvider =
      Get.find<BlueThermalPrinterProdvider>();
  // BlueThermalPrinterProdvider blueThermalPrinterProdvider =
  // BlueThermalPrinterProdvider();

  @override
  void onReady() async {
    // UINotification.showLoading();
    await blueThermalPrinterProdvider.initPlatformState();

    super.onReady();
  }

  @override
  void onClose() {
    blueThermalPrinterProdvider.subscription?.cancel();
    blueThermalPrinterProdvider.subscriptionBtStatus?.cancel();
    blueThermalPrinterProdvider.subscriptionUsbStatus?.cancel();
    blueThermalPrinterProdvider.portController.dispose();
    blueThermalPrinterProdvider.ipController.dispose();
    super.onClose();
  }

//--------------------------//
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

  @override
  void onInit() {
    deliveryDataProvider.deliverySaleInvoiceCtrl = this;
    // params = Get.arguments;
    // if (params?.refId != null) {
    //   print("object1");
    //   _fetchInvoice();
    // }
    super.onInit();
  }

  _fetchInvoice() {
    print("object2");
    SaleViewRequest saleViewRequest = SaleViewRequest();
    saleViewRequest.saleId = params!.refId;
    // saleViewRequest.saleId = "220";
    // deliveryDataProvider.getSaleInvoice(saleViewRequest);
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
    logger.e("hell");
    log(dataResponse.toJson().toString());
  }

  @override
  actionOnPrint() async {
    UINotification.showLoading();
    blueThermalPrinterProdvider.loadImage(invoiceResponse.value.logoPath);
    await Future.delayed(const Duration(seconds: 2));
    blueThermalPrinterProdvider.printReceiveTest(invoiceResponse.value);
    UINotification.hideLoading();
  }

  printBig() async {
    await Future.delayed(Constants.smallDuration);

    final pffFile = await PdfInvoiceProvider.generate(invoiceResponse.value);
    PdfInvoiceProvider.openFile(pffFile);
    UINotification.hideLoading();
  }
}
