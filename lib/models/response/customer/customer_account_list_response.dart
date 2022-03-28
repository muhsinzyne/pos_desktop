import 'package:posdelivery/models/response/customer/customer_data.dart';

class CustomerAccountListResponse {
  List<CustomerData>? customerList;
  CustomerAccountListResponse();
  CustomerAccountListResponse.fromJSON(List<dynamic> parsedJson) {
    customerList = (parsedJson)
        .map((e) =>
            e == null ? null : CustomerData.fromJson(e as Map<String, dynamic>))
        .cast<CustomerData>()
        .toList();
  }
}
