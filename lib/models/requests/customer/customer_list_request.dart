class CustomerAccountListRequest {
  int page = 0;
  int? limit;
  CustomerAccountListRequest();
  CustomerAccountListRequest.fromJSON(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    limit = parsedJson['limit'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'limit': limit,
      };
}
