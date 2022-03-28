class Data {
  String? id;
  String? groupId;
  String? groupName;
  String? customerGroupId;
  String? customerGroupName;
  String? name;
  String? company;
  String? vatNo;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? phone;
  String? email;
  String? cf1;
  String? cf2;
  String? cf3;
  String? cf4;
  String? cf5;
  String? cf6;
  String? invoiceFooter;
  String? paymentTerm;
  String? logo;
  String? awardPoints;
  String? depositAmount;
  String? priceGroupId;
  String? priceGroupName;
  String? gstNo;

  Data(
      {id,
      groupId,
      groupName,
      customerGroupId,
      customerGroupName,
      name,
      company,
      vatNo,
      address,
      city,
      state,
      postalCode,
      country,
      phone,
      email,
      cf1,
      cf2,
      cf3,
      cf4,
      cf5,
      cf6,
      invoiceFooter,
      paymentTerm,
      logo,
      awardPoints,
      depositAmount,
      priceGroupId,
      priceGroupName,
      gstNo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    customerGroupId = json['customer_group_id'];
    customerGroupName = json['customer_group_name'];
    name = json['name'];
    company = json['company'];
    vatNo = json['vat_no'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    cf1 = json['cf1'];
    cf2 = json['cf2'];
    cf3 = json['cf3'];
    cf4 = json['cf4'];
    cf5 = json['cf5'];
    cf6 = json['cf6'];
    invoiceFooter = json['invoice_footer'];
    paymentTerm = json['payment_term'];
    logo = json['logo'];
    awardPoints = json['award_points'];
    depositAmount = json['deposit_amount'];
    priceGroupId = json['price_group_id'];
    priceGroupName = json['price_group_name'];
    gstNo = json['gst_no'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['group_id'] = groupId;
    data['group_name'] = groupName;
    data['customer_group_id'] = customerGroupId;
    data['customer_group_name'] = customerGroupName;
    data['name'] = name;
    data['company'] = company;
    data['vat_no'] = vatNo;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['postal_code'] = postalCode;
    data['country'] = country;
    data['phone'] = phone;
    data['email'] = email;
    data['cf1'] = cf1;
    data['cf2'] = cf2;
    data['cf3'] = cf3;
    data['cf4'] = cf4;
    data['cf5'] = cf5;
    data['cf6'] = cf6;
    data['invoice_footer'] = invoiceFooter;
    data['payment_term'] = paymentTerm;
    data['logo'] = logo;
    data['award_points'] = awardPoints;
    data['deposit_amount'] = depositAmount;
    data['price_group_id'] = priceGroupId;
    data['price_group_name'] = priceGroupName;
    data['gst_no'] = gstNo;
    return data;
  }
}
