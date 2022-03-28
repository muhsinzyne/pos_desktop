class SaleData {
  num? saleId;
  List<dynamic>? message;
  SaleData();
  SaleData.fromJSON(Map<String, dynamic> parsedJson) {
    saleId = parsedJson['sale_id'];
    message = parsedJson['message'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sale_id': saleId,
        'message': message,
      };
}
