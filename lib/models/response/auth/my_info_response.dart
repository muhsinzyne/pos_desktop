import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/billers.dart';
import 'package:posdelivery/models/response/pos/warehouse.dart';

class MyInfoResponse {
  String? id;
  String? lastIpAddress;
  String? ipAddress;
  String? username;
  String? email;
  String? createdOn;
  String? lastLogin;
  String? active;
  String? firstName;
  String? lastName;
  String? company;
  String? phone;
  String? avatar;
  String? gender;
  String? groupId;
  String? warehouseId;
  String? billerId;
  String? companyId;
  String? showCost;
  String? showPrice;
  String? awardPoints;
  String? viewRight;
  String? editRight;
  String? allowDiscount;
  List<Billers>? billers;
  List<Warehouses>? warehouses;

  Warehouses get cWareHouse {
    if (warehouseId == null || warehouseId == Constants.stringNull) {
      warehouseId = warehouses!.first.id;
      return warehouses!.first;
    } else {
      return warehouses!.firstWhere((element) => element.id == warehouseId);
    }
  }

  Billers get cBiller {
    if (billerId == null || billerId == Constants.stringNull) {
      billerId = billers!.first.id;
      return billers!.first;
    } else {
      return billers!.firstWhere((element) => element.id == billerId);
    }
  }

  MyInfoResponse();
  MyInfoResponse.fromJSON(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    lastIpAddress = parsedJson['last_ip_address'];
    ipAddress = parsedJson['ip_address'];
    username = parsedJson['username'];
    email = parsedJson['email'];
    createdOn = parsedJson['created_on'];
    lastLogin = parsedJson['last_login'];
    active = parsedJson['active'];
    firstName = parsedJson['first_name'];
    lastName = parsedJson['last_name'];
    company = parsedJson['company'];
    phone = parsedJson['phone'];
    avatar = parsedJson['avatar'];
    gender = parsedJson['gender'];
    groupId = parsedJson['group_id'];
    warehouseId = parsedJson['warehouse_id'];
    billerId = parsedJson['biller_id'];
    companyId = parsedJson['company_id'];
    showCost = parsedJson['show_cost'];
    showPrice = parsedJson['show_price'];
    awardPoints = parsedJson['award_points'];
    viewRight = parsedJson['view_right'];
    editRight = parsedJson['edit_right'];
    allowDiscount = parsedJson['allow_discount'];
    billers = (parsedJson['billers'] as List<dynamic>)
        .map((e) =>
            e == null ? null : Billers.fromJSON(e as Map<String, dynamic>))
        .cast<Billers>()
        .toList();
    warehouses = (parsedJson['warehouses'] as List<dynamic>)
        .map((e) =>
            e == null ? null : Warehouses.fromJSON(e as Map<String, dynamic>))
        .cast<Warehouses>()
        .toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'last_ip_address': lastIpAddress,
        'username': username,
        'email': email,
        'created_on': createdOn,
        'last_login': lastLogin,
        'active': active,
        'first_name': firstName,
        'last_name': lastName,
        'company': company,
        'phone': phone,
        'avatar': avatar,
        'gender': gender,
        'group_id': groupId,
        'warehouse_id': warehouseId,
        'biller_id': billerId,
        'company_id': companyId,
        'show_cost': showCost,
        'show_price': showPrice,
        'award_points': awardPoints,
        'view_right': viewRight,
        'edit_right': editRight,
        'allow_discount': allowDiscount,
        'billers': billers!.map((e) => e.toJson()).toList(),
        'warehouses': warehouses!.map((e) => e.toJson()).toList(),
      };
}
