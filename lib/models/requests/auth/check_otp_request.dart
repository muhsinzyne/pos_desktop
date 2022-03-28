class CheckOtpRequest {
  String? otp;
  CheckOtpRequest();
  CheckOtpRequest.fromJSON(Map<String, dynamic> parsedJson) {
    otp = parsedJson['otp'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'OTP': otp,
      };
}
