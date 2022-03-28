class Warehouses {
  String? id;
  String? code;
  String? name;
  String? address;
  String? map;
  String? phone;
  String? email;
  String? priceGroupId;
  Warehouses();
  Warehouses.fromJSON(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    code = parsedJson['code'];
    name = parsedJson['name'];
    address = parsedJson['address'];
    map = parsedJson['map'];
    phone = parsedJson['phone'];
    email = parsedJson['email'];
    priceGroupId = parsedJson['price_group_id'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'code': code,
        'name': name,
        'address': address,
        'map': map,
        'phone': phone,
        'email': email,
        'price_group_id': priceGroupId,
      };
}
