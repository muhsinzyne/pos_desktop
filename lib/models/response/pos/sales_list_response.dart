import 'package:posdelivery/models/response/pos/sales_list.dart';

class SalesListResponse {
  List<SalesInfoShort>? sales;
  SalesListResponse();
  SalesListResponse.fromJSON(List<dynamic> parsedJson) {
    sales = (parsedJson)
        .map((e) => e == null
            ? null
            : SalesInfoShort.fromJSON(e as Map<String, dynamic>))
        .cast<SalesInfoShort>()
        .toList();
  }
}
