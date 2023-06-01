import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/add_sale_response.dart';
import 'package:posdelivery/models/response/pos/product.dart';

abstract class IDeliverySalePaymentController {
  onSaleDone(AddSaleResponse addSaleResponse);
  onSaleError(ErrorMessage err);
  onSaleDoneOffline(AddSaleResponse addSaleResponse);
}
