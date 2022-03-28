class CashSales {
  String? total;
  String? paid;

  CashSales({total, paid});

  CashSales.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['paid'] = paid;
    return data;
  }
}
