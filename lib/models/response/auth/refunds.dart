class Refunds {
  String? total;
  String? returned;

  Refunds({total, returned});

  Refunds.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['returned'] = returned;
    return data;
  }
}
