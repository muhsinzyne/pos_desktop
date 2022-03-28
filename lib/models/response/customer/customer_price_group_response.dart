import 'package:posdelivery/models/response/customer/price_group.dart';

import 'customer_group.dart';

class CustomerPriceGroupsResponse {
  List<CustomerGroups>? customerGroups;
  List<PriceGroups>? priceGroups;

  CustomerPriceGroupsResponse({customerGroups, priceGroups});

  CustomerPriceGroupsResponse.fromJson(Map<String, dynamic> json) {
    if (json['customer_groups'] != null) {
      customerGroups = <CustomerGroups>[];
      json['customer_groups'].forEach((v) {
        customerGroups!.add(CustomerGroups.fromJson(v));
      });
    }
    if (json['price_groups'] != null) {
      priceGroups = <PriceGroups>[];
      json['price_groups'].forEach((v) {
        priceGroups!.add(PriceGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerGroups != null) {
      data['customer_groups'] = customerGroups!.map((v) => v.toJson()).toList();
    }
    if (priceGroups != null) {
      data['price_groups'] = priceGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
