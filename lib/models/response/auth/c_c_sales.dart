class CcSales {
  String? totalCcSlips;
  String? total;
  String? paid;

  CcSales({totalCcSlips, total, paid});

  CcSales.fromJson(Map<String, dynamic> json) {
    totalCcSlips = json['total_cc_slips'];
    total = json['total'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_cc_slips'] = totalCcSlips;
    data['total'] = total;
    data['paid'] = paid;
    return data;
  }
}
