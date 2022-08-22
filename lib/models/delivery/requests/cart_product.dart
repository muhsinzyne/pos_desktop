import 'dart:convert';

import 'package:get/get.dart';
import 'package:posdelivery/models/response/pos/product.dart';

List<CartProduct> cartProductFromJson(String str) => List<CartProduct>.from(
    json.decode(str).map((x) => CartProduct.fromJson(x)));

class CartProduct {
  CartProduct();
  String? itemId;
  int? key;
  // String? status;
  double? subTotal;
  double? grandTotal;
  double? tax;
  // final RxDouble _subTotal = RxDouble(0);
  // double get subTotal => _subTotal.value;
  // set subTotal(double value) {
  //   _subTotal.value = value;
  // }

  // final RxDouble _tax = RxDouble(0);
  // double get tax => _tax.value;
  // set tax(double value) {
  //   _tax.value = value;
  // }

  // bool? isAvailable;
  int? subQty;
  int? quantity;
  Product? cartItem;

  CartProduct.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    key = json['key'];
    // status = json['status'];
    subTotal = json['subTotal'];
    grandTotal = json['grandTotal'];
    tax = json['tax'];
    subQty = json['subQty'];
    quantity = json['quantity'];
    if (json['cartItem'] != false && json['cartItem'] != null) {
      cartItem = Product.fromJson(json['cartItem'] as Map<String, dynamic>);
    } else {
      cartItem = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['key'] = key;
    // data['status'] = status;
    data['subTotal'] = subTotal;
    data['grandTotal'] = grandTotal;
    data['tax'] = tax;
    data['subQty'] = subQty;
    data['quantity'] = quantity;
    data['cartItem'] = cartItem;
    if (cartItem != null) {
      data['cartItem'] = cartItem!.toJson();
    }
    return data;
  }
}
