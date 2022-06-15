class Row {
  String? id;
  String? code;
  String? name;
  String? unit;
  num? price;
  String? alertQuantity;
  String? categoryId;
  String? subcategoryId;
  int? quantity;
  String? taxRate;
  String? trackQuantity;
  String? warehouse;
  String? file;
  String? taxMethod;
  String? type;
  String? supplier3price;
  String? promotion;
  String? promoPrice;
  String? startDate;
  String? endDate;
  String? saleUnit;
  String? purchaseUnit;
  String? brand;
  String? slug;
  String? featured;
  String? weight;
  String? hsnCode;
  String? views;
  String? hide;
  String? secondName;
  String? categoryName;
  String? itemTaxMethod;
  int? qty;
  String? discount;
  String? serial;
  bool? option;
  num? realUnitPrice;
  num? baseQuantity;
  String? baseUnit;
  num? baseUnitPrice;
  String? comment;

  Row({
    this.id,
    this.code,
    this.name,
    this.unit,
    this.price,
    this.alertQuantity,
    this.categoryId,
    this.subcategoryId,
    this.quantity,
    this.taxRate,
    this.trackQuantity,
    this.warehouse,
    this.file,
    this.taxMethod,
    this.type,
    this.supplier3price,
    this.promotion,
    this.promoPrice,
    this.startDate,
    this.endDate,
    this.saleUnit,
    this.purchaseUnit,
    this.brand,
    this.slug,
    this.featured,
    this.weight,
    this.hsnCode,
    this.views,
    this.hide,
    this.secondName,
    this.categoryName,
    this.itemTaxMethod,
    this.qty,
    this.discount,
    this.serial,
    this.option,
    this.realUnitPrice,
    this.baseQuantity,
    this.baseUnit,
    this.baseUnitPrice,
    this.comment,
  });

  Row.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    unit = json['unit'];
    price = num.tryParse(json['price'].toString());
    alertQuantity = json['alert_quantity'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    quantity = json['quantity'];
    taxRate = json['tax_rate'];
    trackQuantity = json['track_quantity'];
    warehouse = json['warehouse'];
    file = json['file'];
    taxMethod = json['tax_method'];
    type = json['type'];
    supplier3price = json['supplier3price'];
    promotion = json['promotion'];
    promoPrice = json['promo_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    saleUnit = json['sale_unit'];
    purchaseUnit = json['purchase_unit'];
    brand = json['brand'];
    slug = json['slug'];
    featured = json['featured'];
    weight = json['weight'];
    hsnCode = json['hsn_code'];
    views = json['views'];
    hide = json['hide'];
    secondName = json['second_name'];
    categoryName = json['category_name'];
    itemTaxMethod = json['item_tax_method'];
    qty = json['qty'];
    discount = json['discount'];
    serial = json['serial'];
    option = json['option'];
    realUnitPrice = num.tryParse(json['real_unit_price'].toString());
    baseQuantity = json['base_quantity'];
    baseUnit = json['base_unit'];
    baseUnitPrice = num.tryParse(json['base_unit_price'].toString());
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['unit'] = unit;
    data['price'] = price;
    data['alert_quantity'] = alertQuantity;
    data['category_id'] = categoryId;
    data['subcategory_id'] = subcategoryId;
    data['quantity'] = quantity;
    data['tax_rate'] = taxRate;
    data['track_quantity'] = trackQuantity;
    data['warehouse'] = warehouse;
    data['file'] = file;
    data['tax_method'] = taxMethod;
    data['type'] = type;
    data['supplier3price'] = supplier3price;
    data['promotion'] = promotion;
    data['promo_price'] = promoPrice;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['sale_unit'] = saleUnit;
    data['purchase_unit'] = purchaseUnit;
    data['brand'] = brand;
    data['slug'] = slug;
    data['featured'] = featured;
    data['weight'] = weight;
    data['hsn_code'] = hsnCode;
    data['views'] = views;
    data['hide'] = hide;
    data['second_name'] = secondName;
    data['category_name'] = categoryName;
    data['item_tax_method'] = itemTaxMethod;
    data['qty'] = qty;
    data['discount'] = discount;
    data['serial'] = serial;
    data['option'] = option;
    data['real_unit_price'] = realUnitPrice;
    data['base_quantity'] = baseQuantity;
    data['base_unit'] = baseUnit;
    data['base_unit_price'] = baseUnitPrice;
    data['comment'] = comment;
    return data;
  }
}
