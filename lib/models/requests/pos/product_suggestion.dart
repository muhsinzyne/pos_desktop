class ProductSuggestionRequest {
  String? term;
  String? warehouseId;
  ProductSuggestionRequest();
  ProductSuggestionRequest.fromJSON(Map<String, dynamic> parsedJson) {
    term = parsedJson['term'];
    warehouseId = parsedJson['warehouse_id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'term': term,
        'warehouse_id': warehouseId,
      };
}
