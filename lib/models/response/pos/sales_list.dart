class SalesInfoShort {
  String? id;
  String? date;
  String? referenceNo;
  String? biller;
  String? customer;
  String? grandTotal;
  String? paid;
  String? balance;
  String? saleStatus;
  String? paymentStatus;
  String? cEmail;
  SalesInfoShort();

  SalesInfoShort.fromJSON(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    date = parsedJson['date'];
    referenceNo = parsedJson['reference_no'];
    biller = parsedJson['biller'];
    customer = parsedJson['customer'];
    grandTotal = parsedJson['grand_total'];
    paid = parsedJson['paid'];
    balance = parsedJson['balance'];
    saleStatus = parsedJson['sale_status'];
    paymentStatus = parsedJson['payment_status'];
    cEmail = parsedJson['cemail'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date,
        'reference_no': referenceNo,
        'biller': biller,
        'customer': customer,
        'grand_total': grandTotal,
        'paid': paid,
        'balance': balance,
        'sale_status': saleStatus,
        'payment_status': paymentStatus,
        'cemail': cEmail,
      };
}
