import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/add_sale_response.dart';

abstract class INewSalePaymentController {
  onSaleDone(AddSaleResponse addSaleResponse);
  onSaleError(ErrorMessage err);
}
