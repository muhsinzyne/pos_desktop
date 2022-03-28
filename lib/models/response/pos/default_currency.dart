class DefaultCurrency {
  String? id;
  String? code;
  String? name;
  String? rate;
  String? autoUpdate;
  String? symbol;

  DefaultCurrency();

  DefaultCurrency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    rate = json['rate'];
    autoUpdate = json['auto_update'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['rate'] = rate;
    data['auto_update'] = autoUpdate;
    data['symbol'] = symbol;
    return data;
  }
}
