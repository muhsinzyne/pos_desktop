import 'dart:io';

import 'package:dio/dio.dart';

class ExpenseAddRequest {
  String? date;
  String? reference;
  String? amount;
  String? note;
  String? category_id;
  String? warehouse_id;

  ExpenseAddRequest({
    date,
    reference,
    amount,
    note,
    category,
    warehouse,
  });

  ExpenseAddRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    reference = json['reference'];
    note = json['note'];
    category_id = json['category_id'];
    warehouse_id = json['warehouse_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['amount'] = amount;
    data['reference'] = reference;
    data['note'] = note;
    data['category_id'] = category_id;
    data['warehouse_id'] = warehouse_id;
    return data;
  }
}
