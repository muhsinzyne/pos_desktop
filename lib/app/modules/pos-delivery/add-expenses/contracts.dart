import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/models/response/error_message.dart';

abstract class IDeliveryExpenseAddController {
//  customerGroupFetchDone(
  //    CustomerPriceGroupsResponse customerPriceGroupsResponse);
  //onCustomerGroupFetchError(ErrorMessage err);
  onExpenseAddDone(StoreAddResponse customerAddResponse);
  onExpenseAddError(ErrorMessage err);
}
