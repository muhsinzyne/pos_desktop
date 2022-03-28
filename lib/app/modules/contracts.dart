import 'package:posdelivery/models/response/auth/employee_info.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';

abstract class IBaseGetXController {
  void onLoadTokenValid(EmployeeInfo employeeInfo);
  void onLoadTokenInvalid();
  void validateLogin();
  void validateToken();
  void validateLicence();
  void onInvalidLicence();
  void onValidLicence();
  void onTokenValid(MyInfoResponse myInfo);
}
