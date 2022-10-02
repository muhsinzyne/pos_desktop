import 'package:get/get.dart';
import 'package:posdelivery/models/response/desktop/product_offline.dart';
import 'package:posdelivery/models/response/pos/product.dart';

class CartOfflineProduct {
  CartOfflineProduct();
  String? itemId;
  final RxDouble _subTotal = RxDouble(0);
  double get subTotal => _subTotal.value;
  set subTotal(double value) {
    _subTotal.value = value;
  }

  bool? isAvailable;
  int? subQty;
  int? quantity;
  ProductOffline? cartItem;
}
