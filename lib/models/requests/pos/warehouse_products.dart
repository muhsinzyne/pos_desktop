class WarehouseProductRequest {
  int? page;
  int? limit;
  String type = 'limit';
  WarehouseProductRequest();
  WarehouseProductRequest.fromJSON(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    limit = parsedJson['limit'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'limit': limit,
        'type': type,
      };
}
