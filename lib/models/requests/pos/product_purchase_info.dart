import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/pos/units.dart';

class ProductPurchaseInfo {
  String? uniqueId;
  String? itemId;
  String? productId;
  String? itemType;
  bool? comboItems;
  num itemPrice = 0.0;
  num itemQty = 1;
  num itemAQty = 0;
  String? itemTaxMethod;
  num? itemDs;
  num itemDiscount = 0.0;
  String? itemCode;
  String? itemSerial;
  String? itemName;
  Units? productUnit;
  String? baseQuantity;
  num unitPrice = 0.0;
  num productTax = 0.0;
  num taxVal = 0.0;
  String? taxRate;
  num subTotal = 0.0;
  num totalAmount = 0.0;
  num totalTax = 0.0;
  Units? cUnit;
  num? avlQty;
  num unitMulti = 1;
  Product? rowProduct;
  ProductPurchaseInfo();

  num get netUnitProductPrice {
    return (unitPrice - taxVal);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'unique_id': uniqueId,
        'itemId': itemId,
        'productId': productId,
        'itemPrice': itemPrice,
        'itemQty': itemQty,
        'itemDiscount': itemDiscount,
        'unitPrice': unitPrice,
        'productTax': productTax,
        'taxVal': taxVal,
        'taxRate': taxRate,
        'quantity': avlQty,
        //'cUnit': cUnit.toJson(),
      };
}
