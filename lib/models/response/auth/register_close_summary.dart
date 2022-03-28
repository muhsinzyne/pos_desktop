import 'package:posdelivery/models/response/auth/cash_sales.dart';
import 'package:posdelivery/models/response/auth/ch_sales.dart';
import 'package:posdelivery/models/response/auth/refunds.dart';
import 'package:posdelivery/models/response/auth/returns.dart';

import 'c_c_sales.dart';

class RegisterCloseSummary {
  String? cashInHand;
  String? registerOpenTime;
  List<String>? error;
  CcSales? ccSales;
  CashSales? cashSales;
  ChSales? chSales;
  ChSales? gCSales;
  ChSales? pppSales;
  ChSales? stripeSales;
  ChSales? authorizeSales;
  CashSales? totalSales;
  Refunds? refunds;
  Returns? returns;
  Refunds? cashRefunds;
  Returns? expenses;
  String? suspendedBills;
  String? userId;
  num saleCount = 0;

  double get inHandTotal {
    var cashOpen = double.tryParse(cashInHand ?? '0.0') ?? 0.0;
    var total = double.tryParse(totalSales?.total ?? '0.0') ?? 0.0;
    return (cashOpen + total);
  }

  double get saleAmount {
    var total = double.tryParse(totalSales?.total ?? '0.0') ?? 0.0;
    return total;
  }

  double get openCash {
    var cashOpen = double.tryParse(cashInHand ?? '0.0') ?? 0.0;
    return cashOpen;
  }

  RegisterCloseSummary(
      {cashInHand,
      registerOpenTime,
      error,
      ccSales,
      cashSales,
      chSales,
      gCSales,
      pppSales,
      stripeSales,
      authorizeSales,
      totalSales,
      refunds,
      returns,
      cashRefunds,
      expenses,
      suspendedBills,
      userId});

  RegisterCloseSummary.fromJson(Map<String, dynamic> json) {
    cashInHand = json['cash_in_hand'];
    registerOpenTime = json['register_open_time'];
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error!.add(v.toString());
      });
    }
    ccSales =
        json['ccsales'] != null ? CcSales.fromJson(json['ccsales']) : null;
    cashSales = json['cashsales'] != null
        ? CashSales.fromJson(json['cashsales'])
        : null;
    chSales =
        json['chsales'] != null ? ChSales.fromJson(json['chsales']) : null;
    gCSales =
        json['gcsales'] != null ? ChSales.fromJson(json['gcsales']) : null;
    pppSales =
        json['pppsales'] != null ? ChSales.fromJson(json['pppsales']) : null;
    stripeSales = json['stripesales'] != null
        ? ChSales.fromJson(json['stripesales'])
        : null;
    authorizeSales = json['authorizesales'] != null
        ? ChSales.fromJson(json['authorizesales'])
        : null;
    totalSales = json['totalsales'] != null
        ? CashSales.fromJson(json['totalsales'])
        : null;
    refunds =
        json['refunds'] != null ? Refunds.fromJson(json['refunds']) : null;
    returns =
        json['returns'] != null ? Returns.fromJson(json['returns']) : null;
    cashRefunds = json['cashrefunds'] != null
        ? Refunds.fromJson(json['cashrefunds'])
        : null;
    expenses =
        json['expenses'] != null ? Returns.fromJson(json['expenses']) : null;
    suspendedBills = json['suspended_bills'];
    userId = json['user_id'];
    saleCount = json['sale_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cash_in_hand'] = cashInHand;
    data['register_open_time'] = registerOpenTime;
    if (error != null) {
      data['error'] = error!.map((v) => v.toString()).toList();
    }
    if (ccSales != null) {
      data['ccsales'] = ccSales!.toJson();
    }
    if (cashSales != null) {
      data['cashsales'] = cashSales!.toJson();
    }
    if (chSales != null) {
      data['chsales'] = chSales!.toJson();
    }
    if (gCSales != null) {
      data['gcsales'] = gCSales!.toJson();
    }
    if (pppSales != null) {
      data['pppsales'] = pppSales!.toJson();
    }
    if (stripeSales != null) {
      data['stripesales'] = stripeSales!.toJson();
    }
    if (authorizeSales != null) {
      data['authorizesales'] = authorizeSales!.toJson();
    }
    if (totalSales != null) {
      data['totalsales'] = totalSales!.toJson();
    }
    if (refunds != null) {
      data['refunds'] = refunds!.toJson();
    }
    if (returns != null) {
      data['returns'] = returns!.toJson();
    }
    if (cashRefunds != null) {
      data['cashrefunds'] = cashRefunds!.toJson();
    }
    if (expenses != null) {
      data['expenses'] = expenses!.toJson();
    }
    data['suspended_bills'] = suspendedBills;
    data['user_id'] = userId;
    data['sale_count'] = saleCount;
    return data;
  }
}
