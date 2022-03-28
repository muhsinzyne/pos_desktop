class ReturnPayments {
  String? id;
  String? date;
  String? saleId;
  String? returnId;
  String? purchaseId;
  String? referenceNo;
  String? transactionId;
  String? paidBy;
  String? chequeNo;
  String? ccNo;
  String? ccHolder;
  String? ccMonth;
  String? ccYear;
  String? ccType;
  String? amount;
  String? currency;
  String? createdBy;
  String? attachment;
  String? type;
  String? note;
  String? posPaid;
  String? posBalance;
  String? approvalCode;

  ReturnPayments();
  ReturnPayments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    saleId = json['sale_id'];
    returnId = json['return_id'];
    purchaseId = json['purchase_id'];
    referenceNo = json['reference_no'];
    transactionId = json['transaction_id'];
    paidBy = json['paid_by'];
    chequeNo = json['cheque_no'];
    ccNo = json['cc_no'];
    ccHolder = json['cc_holder'];
    ccMonth = json['cc_month'];
    ccYear = json['cc_year'];
    ccType = json['cc_type'];
    amount = json['amount'];
    currency = json['currency'];
    createdBy = json['created_by'];
    attachment = json['attachment'];
    type = json['type'];
    note = json['note'];
    posPaid = json['pos_paid'];
    posBalance = json['pos_balance'];
    approvalCode = json['approval_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['sale_id'] = saleId;
    data['return_id'] = returnId;
    data['purchase_id'] = purchaseId;
    data['reference_no'] = referenceNo;
    data['transaction_id'] = transactionId;
    data['paid_by'] = paidBy;
    data['cheque_no'] = chequeNo;
    data['cc_no'] = ccNo;
    data['cc_holder'] = ccHolder;
    data['cc_month'] = ccMonth;
    data['cc_year'] = ccYear;
    data['cc_type'] = ccType;
    data['amount'] = amount;
    data['currency'] = currency;
    data['created_by'] = createdBy;
    data['attachment'] = attachment;
    data['type'] = type;
    data['note'] = note;
    data['pos_paid'] = posPaid;
    data['pos_balance'] = posBalance;
    data['approval_code'] = approvalCode;
    return data;
  }
}
