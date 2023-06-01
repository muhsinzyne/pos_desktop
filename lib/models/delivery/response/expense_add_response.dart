import 'package:posdelivery/models/response/customer/add_data.dart';

class ExpenseAddResponse {
  String? message;
  Data? data;

  ExpenseAddResponse({this.message, this.data});

  ExpenseAddResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
