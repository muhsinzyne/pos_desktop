import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/auth/employee_info.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/response/error_message.dart';

abstract class IDashboardScreenController {
  void onLoadTokenValid(EmployeeInfo employeeInfo);
  void onLoadTokenInvalid();

  onCurrentRegisterResponseDone(CurrentRegisterResponse currentRegisterResponse);
  onCurrentRegisterNotOpen(ErrorMessage errorMessage);
  onRegisterCloseSummaryDone(RegisterCloseSummary rSummary);
  onRegisterCloseSummaryError(ErrorMessage errorMessage);
}
