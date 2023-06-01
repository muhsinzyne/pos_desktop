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

class NewPrintInvoiceScreenController extends BaseGetXController {
  BlueThermalPrinterProdvider blueThermalPrinterProdvider =
      Get.find<BlueThermalPrinterProdvider>();

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

  InvoiceResponse invoiceResponse = InvoiceResponse();

  @override
  void onInit() {
    invoiceResponse = Get.arguments;
    Logger().w(invoiceResponse.toJson());
    // if (params?.refId != null) {
    //   print("object1");
    //   _fetchInvoice();
    // }
    super.onInit();
  }

  actionOnPrint() async {
    UINotification.showLoading();
    blueThermalPrinterProdvider.loadImage(invoiceResponse.logoPath);
    await Future.delayed(const Duration(seconds: 2));
    blueThermalPrinterProdvider.printReceiveTest(invoiceResponse);
    UINotification.hideLoading();
  }
}
