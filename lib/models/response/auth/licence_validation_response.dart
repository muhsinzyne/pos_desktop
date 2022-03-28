class LicenceValidationResponse {
  String? api;
  String? appPrefix;
  LicenceValidationResponse();
  LicenceValidationResponse.fromJSON(Map<String, dynamic> parsedJson) {
    api = parsedJson['api'];
    appPrefix = 'demo';
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'api': api,
        'app_prefix': appPrefix,
      };
}
