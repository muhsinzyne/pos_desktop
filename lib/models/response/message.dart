class CommonMessage {
  String? message;
  CommonMessage();
  CommonMessage.fromJSON(Map<String, dynamic> parsedJson) {
    message = parsedJson['message'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
      };
}
