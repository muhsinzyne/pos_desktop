class ValidateLicenceRequest {
  String? licenceCode;
  String? appId;
  String? appMode;
  ValidateLicenceRequest();
  ValidateLicenceRequest.fromJSON(Map<String, dynamic> parsedJson) {
    licenceCode = parsedJson['licence_code'];
    appId = parsedJson['app_id'];
    appMode = parsedJson['app_mode'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'licence_code': licenceCode,
        'app_id': appId,
        'app_mode': appMode,
      };

  Map<String, dynamic> dummy() => <String, dynamic>{
        'licence_code': 'OIMIGJKJ7I',
        'app_id': '3484374-223723737-23333',
        'app_mode': 'ios',
      };
}
