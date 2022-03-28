class LoginRequest {
  String? password;
  String? username;
  bool? rememberMe;
  LoginRequest();
  LoginRequest.fromJSON(Map<String, dynamic> parsedJson) {
    password = parsedJson['password'];
    username = parsedJson['username'];
    rememberMe = parsedJson['remember_me'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'username': username,
        'password': password,
        'remember_me': true,
      };

  Map<String, dynamic> dummy() => <String, dynamic>{
        'username': "m.muhsin",
        'password': "1Message!@#\$%",
        'remember_me': true,
      };
}
