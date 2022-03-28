class CustomerSearchRequest {
  String? term;
  CustomerSearchRequest();
  CustomerSearchRequest.fromJSON(Map<String, dynamic> parsedJson) {
    term = parsedJson['term'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'term': term,
      };
}
