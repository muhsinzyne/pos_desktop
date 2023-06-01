import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/auth/open_register_response.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/response/auth/close_register_response.dart';
abstract class INewDashboardScreenController {
  // void onLoadTokenValid(EmployeeInfo employeeInfo);
  // void onLoadTokenInvalid();

  onCurrentRegisterResponseDone(CurrentRegisterResponse  currentRegisterResponse);
  onCurrentRegisterNotOpen(ErrorMessage errorMessage);
  onRegisterCloseSummaryDone(RegisterCloseSummary rSummary);
  onRegisterCloseSummaryError(ErrorMessage errorMessage);
  onCloseRegisterError(ErrorMessage errorMessage);
  onCloseRegisterDone(CloseRegisterResponse closeRegisterResponse);

  //test
  // onCustomerOfflineListDone(Response response);
  // onCustomerOfflineListError(ErrorMessage err);

  ///Desktop data syncing
  onOpenRegisterDone(OpenRegisterResponse openRegisterResponse);
  onOpenRegisterError(ErrorMessage err);
  // onCustomerOffListDone(List<CustomerListOffResponse> cListRes);
  // onCustomerOffListError(ErrorMessage err);
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
