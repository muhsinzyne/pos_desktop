// To parse this JSON data, do
//
//     final customerGroupResponse = customerGroupResponseFromJson(jsonString);

import 'dart:convert';

List<CustomerGroupResponse> customerGroupResponseFromJson(String str) =>
    List<CustomerGroupResponse>.from(
        json.decode(str).map((x) => CustomerGroupResponse.fromJson(x)));

String customerGroupResponseToJson(List<CustomerGroupResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerGroupResponse {
  CustomerGroupResponse({
    this.id,
    this.name,
    this.percent,
  });

  String? id;
  String? name;
  String? percent;

  factory CustomerGroupResponse.fromJson(Map<String, dynamic> json) =>
      CustomerGroupResponse(
        id: json["id"],
        name: json["name"],
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "percent": percent,
      };
}
