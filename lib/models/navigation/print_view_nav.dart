class PrintViewNavParams {
  String? refId;
  PrintViewNavParams();
  PrintViewNavParams.fromJSON(Map<String, dynamic> parsedJson) {
    refId = parsedJson['ref_id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ref_id': refId,
      };
}
