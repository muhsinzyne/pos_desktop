class SalesListRequest {
  int page = 0;
  int? limit;
  int? warehouseId;
  String orderBy = 'desc';
  String? customerId;
  SalesListRequest();
  SalesListRequest.fromJSON(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    limit = parsedJson['limit'];
    warehouseId = parsedJson['warehouse_id'];
    orderBy = parsedJson['order_by'];
    customerId = parsedJson['customer_id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'limit': limit,
        'warehouse_id': warehouseId,
        'order_by': orderBy,
        'customer': customerId,
      };
}
