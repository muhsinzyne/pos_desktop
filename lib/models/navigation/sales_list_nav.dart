class SalesListNavParams {
  String? customerId;
  String? customerName;
  SalesListNavParams();
  SalesListNavParams.fromJSON(Map<String, dynamic> parsedJson) {
    customerId = parsedJson['customer_id'];
    customerName = parsedJson['customer_name'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'customer_id': customerId,
        'customer_name': customerName
      };
}
