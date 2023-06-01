class CloseRegisterResponse {
  String? message;
  CloseRegisterResponse();
  CloseRegisterResponse.fromJSON(Map<String, dynamic> parsedJson) {
    message = parsedJson['message'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
      };
}
