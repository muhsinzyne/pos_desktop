class ProductOffline {
  String? code;
  String? name;
  int? quantity;
  int? price;
  int? cost;
  String? unit;
  String? tax;
  String? category;
  String? slug;
  String? secondaryName;
  String? weight;
  String? barcodeSymbology;
  String? brand;
  String? subCategory;
  String? defaultSaleUnit;
  String? defaultPurchaseUnit;
  String? taxMethod;
  int? alertQuantity;
  String? productImage;
  String? productGallery;
  String? productDetails;
  ProductOffline();
  // ProductOffline({
  //   code,
  //   name,
  //   quantity,
  //   price,
  //   cost,
  //   unit,
  //   tax,
  //   category,
  //   slug,
  //   secondaryName,
  //   wieght,
  //   barcodeSymbology,
  //   brand,
  //   subCategory,
  // });
  ProductOffline.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    name = json['Name'];
    quantity = json['qty'];
    price = json['Price'];
    cost = json['Cost'];
    unit = json['Unit Code'];
    tax = json[' Tax Rate Name'];
    category = json['Category Code'];
    slug = json['slug'];
    secondaryName = json[' Second Name'];
    weight = json['weight'];
    barcodeSymbology = json['Barcode Symbology'];
    brand = json['Brand'];
    subCategory = json['Subcategory Code'];
    defaultSaleUnit = json['Sale Unit Code'];
    defaultPurchaseUnit = json[' Purchase Unit Code'];
    taxMethod = json['Tax Method'];
    alertQuantity = json['Alert Quantity'];
    productImage = json['Image'];
    productGallery = json['productGallery'];
    productDetails = json['productDetails'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['cost'] = cost;
    data['unit'] = unit;
    data['tax'] = tax;
    data['category'] = category;
    data['slug'] = slug;
    data['secondayName'] = secondaryName;
    data['weight'] = weight;
    data['barcodeSymbology'] = barcodeSymbology;
    data['brand'] = brand;
    data['subCategory'] = subCategory;
    data['defaultSaleUnit'] = defaultSaleUnit;
    data['defaultPurchaseUnit'] = defaultPurchaseUnit;
    data['taxMethod'] = taxMethod;
    data['alertQuantity'] = alertQuantity;
    data['productImage'] = productImage;
    data['productGallery'] = productGallery;
    data['productDetails'] = productDetails;
    return data;
  }
}
