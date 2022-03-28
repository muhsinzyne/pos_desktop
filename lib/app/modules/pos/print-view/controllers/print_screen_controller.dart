import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos/print-view/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/navigation/print_view_nav.dart';
import 'package:posdelivery/models/requests/pos/sale_view_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/providers/local/print_provider.dart';

class PrintScreenController extends BaseGetXController
    implements IPrintScreenController {
  PrintProvider printProvider = Get.find<PrintProvider>();
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  PrintViewNavParams? params;
  var invoiceResponse = InvoiceResponse().obs;
  @override
  void onInit() {
    posDataProvider.printCtrl = this;
    params = Get.arguments;
    if (params!.refId != null) {
      _fetchInvoice();
    }
    super.onInit();
  }

  _fetchInvoice() {
    SaleViewRequest saleViewRequest = SaleViewRequest();
    saleViewRequest.saleId = params!.refId;
    posDataProvider.getSaleInvoice(saleViewRequest);
  }

  @override
  void onReady() {
    UINotification.showLoading();
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
    print(invoiceResponse.toJson());
  }

  @override
  actionOnPrint() async {
    UINotification.showLoading();
    printProvider.loadImage(invoiceResponse.value.logoPath);
    await Future.delayed(Constants.smallDuration);

    printProvider.printPosInvoice(invoiceResponse.value);

    UINotification.hideLoading();
  }
}
