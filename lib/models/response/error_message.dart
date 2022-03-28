class ErrorMessage {
  String? message;
  ErrorMessage();
  ErrorMessage.fromJSON(Map<String, dynamic> parsedJson) {
    message = parsedJson['message'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
      };
}
