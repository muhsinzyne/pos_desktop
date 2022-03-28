class CreatedBy {
  String? id;
  String? username;
  String? email;
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

  CreatedBy();

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    active = json['active'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    phone = json['phone'];
    avatar = json['avatar'];
    gender = json['gender'];
    groupId = json['group_id'];
    warehouseId = json['warehouse_id'];
    billerId = json['biller_id'];
    companyId = json['company_id'];
    showCost = json['show_cost'];
    showPrice = json['show_price'];
    awardPoints = json['award_points'];
    viewRight = json['view_right'];
    editRight = json['edit_right'];
    allowDiscount = json['allow_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['active'] = active;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['gender'] = gender;
    data['group_id'] = groupId;
    data['warehouse_id'] = warehouseId;
    data['biller_id'] = billerId;
    data['company_id'] = companyId;
    data['show_cost'] = showCost;
    data['show_price'] = showPrice;
    data['award_points'] = awardPoints;
    data['view_right'] = viewRight;
    data['edit_right'] = editRight;
    data['allow_discount'] = allowDiscount;
    return data;
  }
}
