import 'package:posdelivery/models/response/customer/customer_account_list_response.dart';
import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/error_message.dart';

import '../../../models/response/customer/customer_price_group_response.dart';

abstract class ICustomerAddController {
  customerGroupFetchDone(CustomerPriceGroupsResponse customerPriceGroupsResponse);
  onCustomerGroupFetchError(ErrorMessage err);
  actionOnSaveRequest();
  onCustomerAddDone(CustomerAddResponse customerAddResponse);
  onCustomerAddError(ErrorMessage err);
}

abstract class ICustomerListController {
  onCustomerListFetchError(ErrorMessage err);
  onCustomerListFetchDone(CustomerAccountListResponse customerListResponse);
}
