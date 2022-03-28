import 'package:posdelivery/models/response/auth/user_data.dart';

class LoginResponse {
  bool? status;
  String? message;
  UserData? data;
  LoginResponse();
  LoginResponse.fromJSON(Map<String, dynamic> parsedJson) {
    data = parsedJson['data'] == null
        ? null
        : UserData.fromJSON(parsedJson['data']);
    message = parsedJson['message'];
    status = parsedJson['status'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
        'status': status,
        'data': data,
      };
}
