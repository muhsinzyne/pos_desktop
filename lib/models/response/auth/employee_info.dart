import 'package:posdelivery/models/response/auth/user_info.dart';

class EmployeeInfo {
  UserInfo? userInfo;
  EmployeeInfo();
  EmployeeInfo.fromJSON(Map<String, dynamic> parsedJson) {
    userInfo = parsedJson['userInfo'] == null
        ? null
        : UserInfo.fromJSON(parsedJson['userInfo']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userInfo': userInfo?.toJson(),
      };
}
