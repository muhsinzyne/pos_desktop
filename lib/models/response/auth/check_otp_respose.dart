class CheckOtpResponse {
  String? token;
  CheckOtpResponse();
  CheckOtpResponse.fromJSON(Map<String, dynamic> parsedJson) {
    token = parsedJson['token'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
      };
}
