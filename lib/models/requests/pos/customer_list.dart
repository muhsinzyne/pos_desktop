class CustomerListRequest {
  int? page;
  int? limit;
  String type = 'limit';
  CustomerListRequest();
  CustomerListRequest.fromJSON(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    limit = parsedJson['limit'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'limit': limit,
        'type': type,
      };
}
