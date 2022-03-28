class RegisterCloseSummaryRequest {
  String? registerId;
  RegisterCloseSummaryRequest();
  RegisterCloseSummaryRequest.fromJSON(Map<String, dynamic> parsedJson) {
    registerId = parsedJson['register_id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'register_id': registerId,
      };
}
