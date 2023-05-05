import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';

abstract class INewStoreScreenController {
  // void onLoadTokenValid(EmployeeInfo employeeInfo);
  // void onLoadTokenInvalid();

  // onCurrentRegisterResponseDone(
  //     CurrentRegisterResponse currentRegisterResponse);
  // onCurrentRegisterNotOpen(ErrorMessage errorMessage);
  // onRegisterCloseSummaryDone(RegisterCloseSummary rSummary);
  // onRegisterCloseSummaryError(ErrorMessage errorMessage);

  //test
  // onCustomerOfflineListDone(Response response);
  // onCustomerOfflineListError(ErrorMessage err);

  ///Desktop data syncing
  // onProductListDone(List<Product> productRes);
  // onProductListError(ErrorMessage err);
  onCustomerListDone(List<CustomerListOffResponse> cListRes);
  onCustomerListError(ErrorMessage err);
  // onWarehouseOffListDone(List<WarehouseListResponse> wListRes);
  // onWarehouseOffListError(ErrorMessage err);
  // onWProductOffListDone(List<WarehouseProductsResponse> wPrdtListRes);
  // onWProductOffListError(ErrorMessage err);
  // onCustomerGrpOffListDone(List<CustomerGroupResponse> cGrpRes);
  // onCustomerGrpOffListError(ErrorMessage err);

  // customerGroupFetchDone(
  //     CustomerPriceGroupsResponse customerPriceGroupsResponse);
  // onCustomerGroupFetchError(ErrorMessage err);
  // myInfoFetchDone(MyInfoResponse myInfoResponse);
  // myInfoFetchError(ErrorMessage err);
}
