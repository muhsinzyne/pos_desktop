class CustomerGroups {
  String? id;
  String? name;
  String? percent;

  CustomerGroups({id, name, percent});

  CustomerGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['percent'] = percent;
    return data;
  }
}
