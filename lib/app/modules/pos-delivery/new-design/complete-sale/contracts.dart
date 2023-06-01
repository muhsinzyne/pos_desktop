import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';

abstract class INewCompleteSaleScreenController {
  onSaleViewFetchDone(InvoiceResponse invoiceResponse);
  onSaleViewError(ErrorMessage errorMessage);
}
