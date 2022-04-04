import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/auth/employee_info.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/response/desktop/customer_group.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/error_message.dart';

abstract class IDashboardScreenController {
  void onLoadTokenValid(EmployeeInfo employeeInfo);
  void onLoadTokenInvalid();

  onCurrentRegisterResponseDone(
      CurrentRegisterResponse currentRegisterResponse);
  onCurrentRegisterNotOpen(ErrorMessage errorMessage);
  onRegisterCloseSummaryDone(RegisterCloseSummary rSummary);
  onRegisterCloseSummaryError(ErrorMessage errorMessage);

  ///Desktop data syncing
  onCustomerOffListDone(List<CustomerListOffResponse> cListRes);
  onCustomerOffListError(ErrorMessage err);
  onWarehouseOffListDone(List<WarehouseListResponse> wListRes);
  onWarehouseOffListError(ErrorMessage err);
  onWProductOffListDone(List<WarehouseProductsResponse> wPrdtListRes);
  onWProductOffListError(ErrorMessage err);
  onCustomerGrpOffListDone(List<CustomerGroupResponse> cGrpRes);
  onCustomerGrpOffListError(ErrorMessage err);
}