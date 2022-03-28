class ChSales {
  String? totalCheques;
  String? total;
  String? paid;

  ChSales({totalCheques, total, paid});

  ChSales.fromJson(Map<String, dynamic> json) {
    totalCheques = json['total_cheques'];
    total = json['total'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_cheques'] = totalCheques;
    data['total'] = total;
    data['paid'] = paid;
    return data;
  }
}
