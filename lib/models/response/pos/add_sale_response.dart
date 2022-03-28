import 'package:posdelivery/models/response/pos/sale_data.dart';

class AddSaleResponse {
  bool? status;
  SaleData? data;
  String? message;
  AddSaleResponse();
  AddSaleResponse.fromJSON(Map<String, dynamic> parsedJson) {
    status = parsedJson['status'];
    data = parsedJson['data'] == null
        ? null
        : SaleData.fromJSON(parsedJson['data']);
    message = parsedJson['message'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'data': data!.toJson(),
        'message': message,
      };
}
