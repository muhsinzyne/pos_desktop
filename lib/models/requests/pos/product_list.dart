class ProductListRequest {
  int? page;
  int? limit;
  int? warehouse_id;
  ProductListRequest();
  ProductListRequest.fromJSON(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    limit = parsedJson['limit'];
    warehouse_id = parsedJson['warehouse_id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'limit': limit,
        'warehouse_id': warehouse_id,
      };
}
