import 'package:posdelivery/models/response/pos/customer.dart';

class CustomerListResponse {
  List<CustomerInfo>? customers;
  CustomerListResponse();
  CustomerListResponse.fromJSON(List<dynamic> parsedJson) {
    customers = (parsedJson)
        .map((e) =>
            e == null ? null : CustomerInfo.fromJSON(e as Map<String, dynamic>))
        .cast<CustomerInfo>()
        .toList();
  }
}
