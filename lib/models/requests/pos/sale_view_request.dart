class SaleViewRequest {
  String? saleId;
  SaleViewRequest();
  SaleViewRequest.fromJSON(Map<String, dynamic> parsedJson) {
    saleId = parsedJson['sale_id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sale_id': saleId,
      };
}
