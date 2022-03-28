class Billers {
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
  String? invoiceFooter;
  String? paymentTerm;
  String? logo;
  String? awardPoints;
  String? depositAmount;
  String? priceGroupId;
  String? priceGroupName;
  String? gstNo;
  Billers();

  Billers.fromJSON(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    groupId = parsedJson['group_id'];
    groupName = parsedJson['group_name'];
    customerGroupId = parsedJson['customer_group_id'];
    customerGroupName = parsedJson['customer_group_name'];
    name = parsedJson['name'];
    company = parsedJson['company'];
    vatNo = parsedJson['vat_no'];
    address = parsedJson['address'];
    city = parsedJson['city'];
    state = parsedJson['state'];
    postalCode = parsedJson['postal_code'];
    country = parsedJson['country'];
    phone = parsedJson['phone'];
    email = parsedJson['email'];
    invoiceFooter = parsedJson['invoice_footer'];
    paymentTerm = parsedJson['payment_term'];
    logo = parsedJson['logo'];
    awardPoints = parsedJson['award_points'];
    depositAmount = parsedJson['deposit_amount'];
    priceGroupId = parsedJson['price_group_id'];
    priceGroupName = parsedJson['price_group_name'];
    gstNo = parsedJson['gst_no'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'group_id': groupId,
        'group_name': groupName,
        'customer_group_id': customerGroupId,
        'customer_group_name': customerGroupName,
        'name': name,
        'company': company,
        'vat_no': vatNo,
        'address': address,
        'city': city,
        'state': state,
        'postal_code': postalCode,
        'country': country,
        'phone': phone,
        'email': email,
        'invoice_footer': invoiceFooter,
        'payment_term': paymentTerm,
        'logo': logo,
        'award_points': awardPoints,
        'deposit_amount': depositAmount,
        'price_group_id': priceGroupId,
        'price_group_name': priceGroupName,
        'gst_no': gstNo
      };
}
