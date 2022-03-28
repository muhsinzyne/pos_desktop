class CurrentRegisterResponse {
  String? id;
  String? date;
  String? userId;
  String? cashInHand;
  String? status;
  String? totalCash;
  String? totalCheques;
  String? totalCcSlips;
  String? totalCashSubmitted;
  String? totalChequesSubmitted;
  String? totalCcSlipsSubmitted;
  String? note;
  String? closedAt;
  String? transferOpenedBills;
  String? closedBy;

  CurrentRegisterResponse(
      {id,
      date,
      userId,
      cashInHand,
      status,
      totalCash,
      totalCheques,
      totalCcSlips,
      totalCashSubmitted,
      totalChequesSubmitted,
      totalCcSlipsSubmitted,
      note,
      closedAt,
      transferOpenedBills,
      closedBy});

  CurrentRegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    userId = json['user_id'];
    cashInHand = json['cash_in_hand'];
    status = json['status'];
    totalCash = json['total_cash'];
    totalCheques = json['total_cheques'];
    totalCcSlips = json['total_cc_slips'];
    totalCashSubmitted = json['total_cash_submitted'];
    totalChequesSubmitted = json['total_cheques_submitted'];
    totalCcSlipsSubmitted = json['total_cc_slips_submitted'];
    note = json['note'];
    closedAt = json['closed_at'];
    transferOpenedBills = json['transfer_opened_bills'];
    closedBy = json['closed_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['user_id'] = userId;
    data['cash_in_hand'] = cashInHand;
    data['status'] = status;
    data['total_cash'] = totalCash;
    data['total_cheques'] = totalCheques;
    data['total_cc_slips'] = totalCcSlips;
    data['total_cash_submitted'] = totalCashSubmitted;
    data['total_cheques_submitted'] = totalChequesSubmitted;
    data['total_cc_slips_submitted'] = totalCcSlipsSubmitted;
    data['note'] = note;
    data['closed_at'] = closedAt;
    data['transfer_opened_bills'] = transferOpenedBills;
    data['closed_by'] = closedBy;
    return data;
  }
}
