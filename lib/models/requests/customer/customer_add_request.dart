class CustomerAddRequest {
  String? name;
  String? email;
  String? customerGroup;
  String? priceGroup;
  String? company;
  String? address;
  String? vatNo;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? phone;

  CustomerAddRequest(
      {name,
      email,
      customerGroup,
      priceGroup,
      company,
      address,
      vatNo,
      city,
      state,
      postalCode,
      country,
      phone});

  CustomerAddRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    customerGroup = json['customer_group'];
    priceGroup = json['price_group'];
    company = json['company'];
    address = json['address'];
    vatNo = json['vat_no'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    country = json['country'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['customer_group'] = customerGroup;
    data['price_group'] = priceGroup;
    data['company'] = company;
    data['address'] = address;
    data['vat_no'] = vatNo;
    data['city'] = city;
    data['state'] = state;
    data['postal_code'] = postalCode;
    data['country'] = country;
    data['phone'] = phone;
    return data;
  }
}
