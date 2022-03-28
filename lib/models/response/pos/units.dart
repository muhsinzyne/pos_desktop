class Units {
  String? id;
  String? code;
  String? name;
  String? baseUnit;
  String? operator;
  String? unitValue;
  String? operationValue;

  Units({
    this.id,
    this.code,
    this.name,
    this.baseUnit,
    this.operator,
    this.unitValue,
    this.operationValue,
  });

  Units.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    baseUnit = json['base_unit'];
    operator = json['operator'];
    unitValue = json['unit_value'];
    operationValue = json['operation_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['base_unit'] = baseUnit;
    data['operator'] = operator;
    data['unit_value'] = unitValue;
    data['operation_value'] = operationValue;
    return data;
  }
}
