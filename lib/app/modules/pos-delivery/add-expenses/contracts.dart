import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/models/response/error_message.dart';

abstract class IStoreAddController {
//  customerGroupFetchDone(
  //    CustomerPriceGroupsResponse customerPriceGroupsResponse);
  //onCustomerGroupFetchError(ErrorMessage err);
  actionOnSaveRequest();
  onCustomerAddDone(StoreAddResponse customerAddResponse);
  onCustomerAddError(ErrorMessage err);
}
