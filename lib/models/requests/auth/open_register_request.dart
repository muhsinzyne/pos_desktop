class OpenRegisterRequest {
  String? cashInHand;
  String? openRegister;
  OpenRegisterRequest();
  OpenRegisterRequest.fromJSON(Map<String, dynamic> parsedJson) {
    cashInHand = parsedJson['cash_in_hand'];
    openRegister = parsedJson['open_register'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cash_in_hand': cashInHand,
        'open_register': openRegister,
      };
}
