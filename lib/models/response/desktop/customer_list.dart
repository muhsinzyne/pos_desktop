// To parse this JSON data, do
//
//     final customerListOffResponse = customerListOffResponseFromJson(jsonString);

import 'dart:convert';

List<CustomerListOffResponse> customerListOffResponseFromJson(String str) =>
    List<CustomerListOffResponse>.from(
        json.decode(str).map((x) => CustomerListOffResponse.fromJson(x)));

String customerListOffResponseToJson(List<CustomerListOffResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerListOffResponse {
  CustomerListOffResponse({
    this.id,
    this.company,
    this.name,
    this.email,
    this.phone,
    this.customerGroupName,
    this.vatNo,
    this.account,
    this.awardPoints,
  });

  String? id;
  String? company;
  String? name;
  String? email;
  String? phone;
  String? customerGroupName;
  String? vatNo;
  String? account;
  String? awardPoints;

  factory CustomerListOffResponse.fromJson(Map<String, dynamic> json) =>
      CustomerListOffResponse(
        id: json["id"],
        company: json["company"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        customerGroupName: json["customer_group_name"],
        vatNo: json["vat_no"],
        account: json["account"] == null ? null : json["account"],
        awardPoints: json["award_points"] == null ? null : json["award_points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company,
        "name": name,
        "email": email,
        "phone": phone,
        "customer_group_name": customerGroupName,
        "vat_no": vatNo,
        "account": account == null ? null : account,
        "award_points": awardPoints == null ? null : awardPoints,
      };
}
