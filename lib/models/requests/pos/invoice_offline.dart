import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/desktop/product_offline.dart';
import 'package:posdelivery/models/response/pos/date_formats.dart';
import 'package:posdelivery/models/response/pos/default_currency.dart';
import 'package:posdelivery/models/response/pos/product_row.dart';
import 'package:posdelivery/models/response/pos/return_payments.dart';
import 'package:posdelivery/models/response/pos/return_rows.dart';
import 'package:posdelivery/models/response/pos/return_sale.dart';
import 'package:posdelivery/models/response/pos/sale_payments.dart';
import 'package:posdelivery/models/response/pos/sales_biller.dart';
import 'package:posdelivery/models/response/pos/sales_created_by.dart';
import 'package:posdelivery/models/response/pos/sales_customer.dart';
import 'package:posdelivery/models/response/pos/sales_inv.dart';
import 'package:posdelivery/models/response/pos/sales_pos.dart';
import 'package:posdelivery/models/response/pos/settings.dart';

class InvoiceOfflineResponse {
  String? saleNo;
  String? saleRef;
  List<ProductOffline> rows = [];
  int? totalItem;
  String? date;
  int? totalQty;
  double? subTotal;
  String? discount;
  double? totalTax;
  double? grandTotal;
  String get logoPath {
    return Constants.appLogoPath;
  }

  InvoiceOfflineResponse();
  String get qrCodeString {
    BytesBuilder bytesBuilder = BytesBuilder();

    /// 1 seller Name
    // bytesBuilder.addByte(1);
    // List<int> sellerNameBytes = utf8.encode(biller!.name!);
    // bytesBuilder.addByte(sellerNameBytes.length);
    // bytesBuilder.add(sellerNameBytes);

    // /// 2 Vat No
    // bytesBuilder.addByte(2);
    // List<int> vatNoBytes = utf8.encode(biller!.vatNo!);
    // bytesBuilder.addByte(vatNoBytes.length);
    // bytesBuilder.add(vatNoBytes);

    /// 3 timestamp
    bytesBuilder.addByte(3);
    List<int> timeStampBytes = utf8.encode(date!);
    bytesBuilder.addByte(timeStampBytes.length);
    bytesBuilder.add(timeStampBytes);

    /// 4 invoice amount
    bytesBuilder.addByte(4);
    List<int> invoiceAmountBytes = utf8.encode(grandTotal!.toStringAsFixed(2));
    bytesBuilder.addByte(invoiceAmountBytes.length);
    bytesBuilder.add(invoiceAmountBytes);

    /// 5 Vat Amount
    bytesBuilder.addByte(5);
    List<int> vatAmountBytes = utf8.encode(totalTax!.toStringAsFixed(2));
    bytesBuilder.addByte(vatAmountBytes.length);
    bytesBuilder.add(vatAmountBytes);

    Uint8List qrCodeAsBytes = bytesBuilder.toBytes();
    final Base64Encoder base64encoder = Base64Encoder();
    return base64encoder.convert(qrCodeAsBytes);
  }

  InvoiceOfflineResponse.fromJson(Map<String, dynamic> json) {
    saleNo = json['saleNo'];
    saleRef = json['saleRef'];
    if (json['rows'] != null) {
      rows = <ProductOffline>[];
      json['rows'].forEach((v) {
        rows.add(ProductOffline.fromJson(v));
      });
    }
    totalItem = json['totalItem'];
    date = json['date'];
    totalQty = json['totalQty'];
    subTotal = json['subTotal'];
    discount = json['discount'];
    totalTax = json['totalTax'];
    grandTotal = json['grandTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['saleNo'] = saleNo;
    data['saleRef'] = saleRef;
    if (rows != null) {
      data['rows'] = rows.map((v) => v.toJson()).toList();
    }
    data['totalItem'] = totalItem;
    data['totalQty'] = totalQty;
    data['subTotal'] = subTotal;
    data['discount'] = discount;
    data['totalTax'] = totalTax;
    data['grandTotal'] = grandTotal;
    return data;
  }
}
