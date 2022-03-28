import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/message.dart';

abstract class ICustomerPaymentController {}

abstract class ISalePaymentController {
  onSalePaymentDone(CommonMessage cMess);
  onSalePaymentError(ErrorMessage errorMessage);
}
