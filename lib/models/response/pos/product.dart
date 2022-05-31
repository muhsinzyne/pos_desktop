import 'dart:convert';
import 'package:posdelivery/models/response/pos/row.dart';
import 'package:posdelivery/models/response/pos/tax_rate.dart';
import 'package:posdelivery/models/response/pos/units.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String? id;
  String? itemId;
  String? label;
  String? category;
  Row? row;
  bool? comboItems;
  TaxRate? taxRate;
  List<Units>? units;
  bool? options;

  Product(
      {this.id,
      this.itemId,
      this.label,
      this.category,
      this.row,
      this.comboItems,
      this.taxRate,
      this.units,
      this.options});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    itemId = json['item_id'];
    label = json['label'];
    category = json['category'];
    row = json['row'] != null ? Row.fromJson(json['row']) : null;
    comboItems = json['combo_items'];
    taxRate = json['tax_rate'] != false
        ? TaxRate.fromJson(json['tax_rate'] as Map<String, dynamic>)
        : null;
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(Units.fromJson(v));
      });
    }
    options = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    data['label'] = label;
    data['category'] = category;
    if (row != null) {
      data['row'] = row!.toJson();
    }
    data['combo_items'] = comboItems;
    if (taxRate != null) {
      data['tax_rate'] = taxRate!.toJson();
    }
    if (units != null) {
      data['units'] = units!.map((v) => v.toJson()).toList();
    }
    data['options'] = options;
    return data;
  }
}
