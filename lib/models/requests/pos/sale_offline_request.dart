class SaleOfflineRequest {
  String? customer;
  String? warehouse;
  String? due_date;
  List<String> productCode = [];
  List<String> productName = [];
  List<String> productOption = []; // string bool
  List<String> productComment = []; //empty
  List<String> productTax = [];
  List<String> netPrice = [];
  List<String> unitPrice = [];
  List<String> realUnitPrice = [];
  List<String> quantity = [];
  List<String> productUnit = [];
  String? biller;
  String? posNote;
  String? staffNote;
  List<String> amount = [];
  List<String> balanceAmount = [];
  List<String> paidBy = [];
  List<String> ccNo = [];
  List<String> payingGiftCardNo = [];
  List<String> ccHolder = [];
  List<String> chequeNo = [];
  List<String> ccMonth = [];
  List<String> ccYear = [];
  List<String> ccType = [];
  List<String> ccCvv2 = [];
  List<String> paymentNote = [];
  String? orderTax;
  String? discount;
  String? shipping;
  String? rPaidBy;
  String? totalItems;
  SaleOfflineRequest();
  SaleOfflineRequest.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    warehouse = json['warehouse'];
    due_date = json['due_date'];
    if (json['product_code'] != null) {
      productCode = <String>[];
      json['product_code'].forEach((v) {
        productCode.add(v);
      });
    }
    if (json['product_name'] != null) {
      productName = <String>[];
      json['product_name'].forEach((v) {
        productName.add(v);
      });
    }
    if (json['product_option'] != null) {
      productOption = <String>[];
      json['product_option'].forEach((v) {
        productOption.add(v);
      });
    }
    if (json['product_tax'] != null) {
      productTax = <String>[];
      json['product_tax'].forEach((v) {
        productTax.add(v);
      });
    }
    if (json['net_price'] != null) {
      netPrice = <String>[];
      json['net_price'].forEach((v) {
        netPrice.add(v);
      });
    }
    if (json['unit_price'] != null) {
      unitPrice = <String>[];
      json['unit_price'].forEach((v) {
        unitPrice.add(v);
      });
    }
    if (json['real_unit_price'] != null) {
      realUnitPrice = <String>[];
      json['real_unit_price'].forEach((v) {
        realUnitPrice.add(v);
      });
    }
    if (json['quantity'] != null) {
      quantity = <String>[];
      json['quantity'].forEach((v) {
        quantity.add(v);
      });
      if (json['product_comment'] != null) {
        productComment = <String>[];
        json['product_comment'].forEach((v) {
          productComment.add(v);
        });
      }
    }
    if (json['product_unit'] != null) {
      productUnit = <String>[];
      json['product_unit'].forEach((v) {
        productUnit.add(v);
      });
    }
    biller = json['biller'];
    posNote = json['pos_note'];
    staffNote = json['staff_note'];
    if (json['amount'] != null) {
      amount = <String>[];
      json['amount'].forEach((v) {
        amount.add(v);
      });
    }
    if (json['balance_amount'] != null) {
      balanceAmount = <String>[];
      json['balance_amount'].forEach((v) {
        balanceAmount.add(v);
      });
    }
    if (json['paid_by'] != null) {
      paidBy = <String>[];
      json['paid_by'].forEach((v) {
        paidBy.add(v);
      });
    }
    if (json['cc_no'] != null) {
      ccNo = <String>[];
      json['cc_no'].forEach((v) {
        ccNo.add(v);
      });
    }
    if (json['paying_gift_card_no'] != null) {
      payingGiftCardNo = <String>[];
      json['paying_gift_card_no'].forEach((v) {
        payingGiftCardNo.add(v);
      });
    }
    if (json['cc_holder'] != null) {
      ccHolder = <String>[];
      json['cc_holder'].forEach((v) {
        ccHolder.add(v);
      });
    }
    if (json['cheque_no'] != null) {
      chequeNo = <String>[];
      json['cheque_no'].forEach((v) {
        chequeNo.add(v);
      });
    }
    if (json['cheque_no'] != null) {
      chequeNo = <String>[];
      json['cheque_no'].forEach((v) {
        chequeNo.add(v);
      });
    }
    if (json['cc_month'] != null) {
      ccMonth = <String>[];
      json['cc_month'].forEach((v) {
        ccMonth.add(v);
      });
    }
    if (json['cc_year'] != null) {
      ccYear = <String>[];
      json['cc_year'].forEach((v) {
        ccYear.add(v);
      });
    }
    if (json['cc_type'] != null) {
      ccType = <String>[];
      json['cc_type'].forEach((v) {
        ccType.add(v);
      });
    }
    if (json['cc_cvv2'] != null) {
      ccCvv2 = <String>[];
      json['cc_cvv2'].forEach((v) {
        ccCvv2.add(v);
      });
    }
    if (json['paymnet_note'] != null) {
      paymentNote = <String>[];
      json['paymnet_note'].forEach((v) {
        paymentNote.add(v);
      });
    }
    orderTax = json['order_tax'];
    discount = json['discount'];
    discount = json['discount'];
    shipping = json['shipping'];
    rPaidBy = json['rpaidby'];
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'customer': customer,
        'due_date': due_date,
        'warehouse': warehouse,
        'product_code': productCode,
        'product_name': productName,
        'product_option': productOption,
        'product_comment': productComment,
        'product_tax': productTax,
        'net_price': netPrice,
        'unit_price': unitPrice,
        'real_unit_price': realUnitPrice,
        'quantity': quantity,
        'product_unit': productUnit,
        'biller': biller,
        'pos_note': posNote,
        'staff_note': staffNote,
        'amount': amount,
        'balance_amount': balanceAmount,
        'paid_by': paidBy,
        'cc_no': ccNo,
        'paying_gift_card_no': payingGiftCardNo,
        'cc_holder': ccHolder,
        'cheque_no': chequeNo,
        'cc_month': ccMonth,
        'cc_year': ccYear,
        'cc_type': ccType,
        'cc_cvv2': ccCvv2,
        'payment_note': paymentNote,
        'order_tax': orderTax,
        'discount': discount,
        'shipping': shipping,
        'rpaidby': rPaidBy,
        'total_items': totalItems
      };
}
