class CloseRegisterRequest {
  int? registerid;
  String? totalcash;
  String? totalcashsubmitted;
  String? totalcheques;
  String? totalchequessubmitted;
  String? totalccslips;
  String? totalccslipssubmitted;
  String? note;
  String? closeregister;

  CloseRegisterRequest({this.registerid, this.totalcash, this.totalcashsubmitted, this.totalcheques, this.totalchequessubmitted, this.totalccslips, this.totalccslipssubmitted, this.note, this.closeregister});

  CloseRegisterRequest.fromJson(Map<String, dynamic> json) {
    registerid = json['register_id'];
    totalcash = json['total_cash'];
    totalcashsubmitted = json['total_cash_submitted'];
    totalcheques = json['total_cheques'];
    totalchequessubmitted = json['total_cheques_submitted'];
    totalccslips = json['total_cc_slips'];
    totalccslipssubmitted = json['total_cc_slips_submitted'];
    note = json['note'];
    closeregister = json['close_register'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['register_id'] = registerid;
    data['total_cash'] = totalcash;
    data['total_cash_submitted'] = totalcashsubmitted;
    data['total_cheques'] = totalcheques;
    data['total_cheques_submitted'] = totalchequessubmitted;
    data['total_cc_slips'] = totalccslips;
    data['total_cc_slips_submitted'] = totalccslipssubmitted;
    data['note'] = note;
    data['close_register'] = closeregister;
    return data;
  }
}
