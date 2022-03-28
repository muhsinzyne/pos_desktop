class CustomerInfo {
  String? id;
  String? text;
  String? value;
  String? phone;
  CustomerInfo();

  CustomerInfo.fromJSON(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    text = parsedJson['text'];
    value = parsedJson['value'];
    phone = parsedJson['phone'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'text': text,
        'value': value,
        'phone': phone,
      };
}
