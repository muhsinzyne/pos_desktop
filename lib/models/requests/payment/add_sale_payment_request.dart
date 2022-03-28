class AddSalePaymentRequest {
  String? referenceNo;
  String? saleId;
  String? amountPaid;
  String? paidBy = 'cash';
  AddSalePaymentRequest();
  AddSalePaymentRequest.fromJSON(Map<String, dynamic> parsedJson) {
    referenceNo = parsedJson['reference_no'];
    saleId = parsedJson['sale_id'];
    amountPaid = parsedJson['amount-paid'];
    paidBy = parsedJson['paid_by'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'reference_no': referenceNo,
        'sale_id': saleId,
        'amount-paid': amountPaid,
        'paid_by': paidBy,
      };

  Map<String, dynamic> urlParams() => <String, dynamic>{
        'id': saleId,
      };
}
