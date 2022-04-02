// To parse this JSON data, do
//
//     final warehouseListResponse = warehouseListResponseFromJson(jsonString);

import 'dart:convert';

List<WarehouseListResponse> warehouseListResponseFromJson(String str) =>
    List<WarehouseListResponse>.from(
        json.decode(str).map((x) => WarehouseListResponse.fromJson(x)));

String warehouseListResponseToJson(List<WarehouseListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WarehouseListResponse {
  WarehouseListResponse({
    this.id,
    this.code,
    this.name,
    this.address,
    this.map,
    this.phone,
    this.email,
    this.priceGroupId,
  });

  String? id;
  String? code;
  String? name;
  String? address;
  dynamic map;
  String? phone;
  String? email;
  String? priceGroupId;

  factory WarehouseListResponse.fromJson(Map<String, dynamic> json) =>
      WarehouseListResponse(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        address: json["address"],
        map: json["map"],
        phone: json["phone"],
        email: json["email"],
        priceGroupId: json["price_group_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "address": address,
        "map": map,
        "phone": phone,
        "email": email,
        "price_group_id": priceGroupId,
      };
}
