class ProductByCodeRequest {
  int? code;
  int? customer_id;
  int? warehouse_id;
  ProductByCodeRequest();
  ProductByCodeRequest.fromJSON(Map<String, dynamic> parsedJson) {
    code = parsedJson['code'];
    customer_id = parsedJson['customer_id'];
    warehouse_id = parsedJson['warehouse_id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'customer_id': customer_id,
        'warehouse_id': warehouse_id,
      };
}
