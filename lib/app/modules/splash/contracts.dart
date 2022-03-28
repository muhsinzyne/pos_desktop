import 'package:posdelivery/models/response/auth/employee_info.dart';

abstract class ISplashScreenController {
  void onLoadTokenValid(EmployeeInfo employeeInfo);
  void onLoadTokenInvalid();
}
