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
    data['Code'] = code;
    data['Name'] = name;
    data['qty'] = quantity;
    data['Price'] = price;
    data['Cost'] = cost;
    data['Unit Code'] = unit;
    data['Tax Rate Name'] = tax;
    data['Category Code'] = category;
    data['slug'] = slug;
    data['Second Name'] = secondaryName;
    data['weight'] = weight;
    data['Barcode Symbology'] = barcodeSymbology;
    data['Brand'] = brand;
    data['SubCategory Code'] = subCategory;
    data['Sale Unit Code'] = defaultSaleUnit;
    data['Purchase Unit Code'] = defaultPurchaseUnit;
    data['Tax Method'] = taxMethod;
    data['Alert Quantity'] = alertQuantity;
    data['Image'] = productImage;
    data['productGallery'] = productGallery;
    data['productDetails'] = productDetails;
    return data;
  }
}
