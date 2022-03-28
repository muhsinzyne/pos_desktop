class OpenRegisterResponse {
  bool? status;
  String? message;
  OpenRegisterResponse();
  OpenRegisterResponse.fromJSON(Map<String, dynamic> parsedJson) {
    status = parsedJson['status'];
    message = parsedJson['message'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'message': status,
      };
}
