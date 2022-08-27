import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:posdelivery/models/constants.dart';
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

class InvoiceResponse {
  String? assets;
  Settings? settings;
  DefaultCurrency? defaultCurrency;
  bool? owner;
  String? customerName;
  String? supplier;
  String? admin;
  String? gP;
  DateFormats? dateFormats;
  String? m;
  String? v;
  String? dtLang;
  String? dpLang;
  List<ProductRows> rows = [];
  SalesBiller? biller;
  SalesCustomer? customer;
  List<Payments>? payments;
  SalePos? pos;
  String? barcode;
  ReturnSale? returnSale;

  List<ReturnRows>? returnRows;
  List<ReturnPayments>? returnPayments;
  Inv? inv;
  String? sid;
  bool? modal;
  CreatedBy? createdBy;
  bool? printer;
  String? pageTitle;
  String? qrcodeImage;
  String? userDirectory;
  String? domain;
  InvoiceResponse();

  String get logoPath {
    return domain! +
        Constants.uploadsPath +
        userDirectory! +
        Constants.logosPath +
        biller!.logo!;
  }

  double get totalTax {
    return double.tryParse(inv?.totalTax ?? '0.0')!;
  }

  double get totalPaid {
    return (double.tryParse(inv?.paid ?? '0.0'))!;
  }

  double get grandTotal {
    return (double.tryParse(inv?.grandTotal ?? '0.0'))!;
  }

  double get total {
    return (double.tryParse(inv?.total ?? '0.0'))!;
  }

  String get qrCodeString {
    BytesBuilder bytesBuilder = BytesBuilder();

    /// 1 seller Name
    bytesBuilder.addByte(1);
    List<int> sellerNameBytes = utf8.encode(biller!.name!);
    bytesBuilder.addByte(sellerNameBytes.length);
    bytesBuilder.add(sellerNameBytes);

    /// 2 Vat No
    bytesBuilder.addByte(2);
    List<int> vatNoBytes = utf8.encode(biller!.vatNo!);
    bytesBuilder.addByte(vatNoBytes.length);
    bytesBuilder.add(vatNoBytes);

    /// 3 timestamp
    bytesBuilder.addByte(3);
    List<int> timeStampBytes = utf8.encode(inv!.date!);
    bytesBuilder.addByte(timeStampBytes.length);
    bytesBuilder.add(timeStampBytes);

    /// 4 invoice amount
    bytesBuilder.addByte(4);
    List<int> invoiceAmountBytes = utf8.encode(grandTotal.toStringAsFixed(2));
    bytesBuilder.addByte(invoiceAmountBytes.length);
    bytesBuilder.add(invoiceAmountBytes);

    /// 5 Vat Amount
    bytesBuilder.addByte(5);
    List<int> vatAmountBytes = utf8.encode(totalTax.toStringAsFixed(2));
    bytesBuilder.addByte(vatAmountBytes.length);
    bytesBuilder.add(vatAmountBytes);

    Uint8List qrCodeAsBytes = bytesBuilder.toBytes();
    final Base64Encoder base64encoder = Base64Encoder();
    return base64encoder.convert(qrCodeAsBytes);
  }

  String get qrCodeImageWithOutMeta {
    String base = qrcodeImage!;
    return base.replaceAll('data:image/png;base64,', '');
  }

  getQrCodeWidgetImage() {
    final byteImage = Base64Decoder().convert(qrcodeImage!);
    return byteImage;
  }

  double get balanceAmount {
    var invoiceTotal = 0.0;
    var paidTotal = 0.0;
    var returnPaid = 0.0;
    var balanceAmount = 0.0;
    invoiceTotal = double.tryParse(inv?.grandTotal ?? '0.0')!;
    paidTotal = double.tryParse(inv?.paid ?? '0.0')!;
    if (returnSale != null) {
      returnPaid = double.tryParse(returnSale?.paid ?? '0.0')!;
    }
    balanceAmount = ((invoiceTotal - paidTotal) + returnPaid);
    return balanceAmount;
  }

  InvoiceResponse.fromJson(Map<String, dynamic> json) {
    assets = json['assets'];
    settings =
        json['Settings'] != null ? Settings.fromJson(json['Settings']) : null;
    defaultCurrency = json['default_currency'] != null
        ? DefaultCurrency.fromJson(json['default_currency'])
        : null;
    owner = json['Owner'];
    customerName = json['Customer'];
    supplier = json['Supplier'];
    admin = json['Admin'];
    gP = json['GP'];
    dateFormats = json['dateFormats'] != null
        ? DateFormats.fromJson(json['dateFormats'])
        : null;
    m = json['m'];
    v = json['v'];
    dtLang = json['dt_lang'];
    dpLang = json['dp_lang'];
    if (json['rows'] != null) {
      rows = <ProductRows>[];
      json['rows'].forEach((v) {
        rows.add(ProductRows.fromJson(v));
      });
    }
    biller =
        json['biller'] != null ? SalesBiller.fromJson(json['biller']) : null;
    if (json['customer'] != null) {
      customer = SalesCustomer.fromJson(json['customer']);
    } else {
      customer = null;
    }
    if (json['payments'] != false) {
      payments = <Payments>[];
      print(json['payments']);
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v));
      });
    }
    pos = json['pos'] != null ? SalePos.fromJson(json['pos']) : null;
    barcode = json['barcode'];
    returnSale = json['return_sale'] != null
        ? ReturnSale.fromJson(json['return_sale'])
        : null;
    if (json['return_rows'] != null) {
      returnRows = <ReturnRows>[];
      json['return_rows'].forEach((v) {
        returnRows!.add(ReturnRows.fromJson(v));
      });
    }
    if (json['return_payments'] != null) {
      returnPayments = <ReturnPayments>[];
      json['return_payments'].forEach((v) {
        returnPayments!.add(ReturnPayments.fromJson(v));
      });
    }
    inv = json['inv'] != null ? Inv.fromJson(json['inv']) : null;
    sid = json['sid'];
    modal = json['modal'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    printer = json['printer'];
    pageTitle = json['page_title'];
    qrcodeImage = json['qrcodeImage'];
    userDirectory = json['user_directory'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assets'] = assets;
    if (settings != null) {
      data['Settings'] = settings!.toJson();
    }
    if (defaultCurrency != null) {
      data['default_currency'] = defaultCurrency!.toJson();
    }
    data['Owner'] = owner;
    data['Customer'] = customer;
    data['Supplier'] = supplier;
    data['Admin'] = admin;
    data['GP'] = gP;
    if (dateFormats != null) {
      data['dateFormats'] = dateFormats!.toJson();
    }
    data['m'] = m;
    data['v'] = v;
    data['dt_lang'] = dtLang;
    data['dp_lang'] = dpLang;
    if (rows != null) {
      data['rows'] = rows.map((v) => v.toJson()).toList();
    }
    if (biller != null) {
      data['biller'] = biller!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    if (pos != null) {
      data['pos'] = pos!.toJson();
    }
    data['barcode'] = barcode;
    if (returnSale != null) {
      data['return_sale'] = returnSale!.toJson();
    }
    data['return_rows'] = returnRows;
    if (returnPayments != null) {
      data['return_payments'] = returnPayments!.map((v) => v.toJson()).toList();
    }

    if (inv != null) {
      data['inv'] = inv!.toJson();
    }
    if (returnRows != null) {
      data['return_rows'] = returnRows!.map((v) => v.toJson()).toList();
    }
    data['sid'] = sid;
    data['modal'] = modal;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['printer'] = printer;
    data['page_title'] = pageTitle;
    data['qrcodeImage'] = qrcodeImage;
    data['user_directory'] = userDirectory;
    data['domain'] = domain;
    return data;
  }
}
