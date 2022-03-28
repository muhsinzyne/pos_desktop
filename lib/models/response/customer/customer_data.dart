class CustomerData {
  String? id;
  String? company;
  String? name;
  String? email;
  String? phone;
  String? customerGroupName;
  String? vatNo;
  String? account;
  String? awardPoints;

  CustomerData(
      {id,
      company,
      name,
      email,
      phone,
      customerGroupName,
      vatNo,
      account,
      awardPoints});

  double get dueAccount {
    if (account != null) {
      return double.tryParse(account!)!;
    }
    return 0.0;
  }

  bool get isDue {
    return dueAccount < 0 ? true : false;
  }

  bool get isOverPaid {
    return dueAccount > 0 ? true : false;
  }

  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    customerGroupName = json['customer_group_name'];
    vatNo = json['vat_no'];
    account = json['account'];
    awardPoints = json['award_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company'] = company;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['customer_group_name'] = customerGroupName;
    data['vat_no'] = vatNo;
    data['account'] = account;
    data['award_points'] = awardPoints;
    return data;
  }
}
