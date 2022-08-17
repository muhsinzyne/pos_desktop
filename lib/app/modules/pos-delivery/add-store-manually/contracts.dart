import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/models/response/error_message.dart';

abstract class IDeliveryStoreAddController {
//  customerGroupFetchDone(
  //    CustomerPriceGroupsResponse customerPriceGroupsResponse);
  //onCustomerGroupFetchError(ErrorMessage err);
  onStoreAddDone(StoreAddResponse customerAddResponse);
  onStoreAddError(ErrorMessage err);
}
