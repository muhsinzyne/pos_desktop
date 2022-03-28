class SalePaymentNavParams {
  String? id;
  String? customer;
  String? referenceNo;
  String? paid;
  String? balance;
  String? saleStatus;
  String? paymentStatus;
  SalePaymentNavParams();

  double get paidAmount {
    return double.tryParse(paid!) ?? 0.0;
  }

  double get balanceAmount {
    return double.tryParse(balance!) ?? 0.0;
  }

  double get invoiceTotal {
    return paidAmount + balanceAmount;
  }

  SalePaymentNavParams.fromJSON(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    customer = parsedJson['customer'];
    referenceNo = parsedJson['reference_no'];
    paid = parsedJson['paid'];
    balance = parsedJson['balance'];
    saleStatus = parsedJson['sale_status'];
    paymentStatus = parsedJson['payment_status'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'customer': customer,
        'reference_no': referenceNo,
        'paid': paid,
        'balance': balance,
        'sale_status': saleStatus,
        'payment_status': paymentStatus,
      };
}
