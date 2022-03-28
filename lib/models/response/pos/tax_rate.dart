class TaxRate {
  String? id;
  String? name;
  String? code;
  String? rate;
  String? type;

  TaxRate({this.id, this.name, this.code, this.rate, this.type});

  TaxRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    rate = json['rate'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['rate'] = rate;
    data['type'] = type;
    return data;
  }
}
