import 'package:get/get.dart';
import 'package:posdelivery/models/response/pos/product.dart';

class CartProduct {
  CartProduct();
  String? itemId;
  final RxDouble _subTotal = RxDouble(0);
  double get subTotal => _subTotal.value;
  set subTotal(double value) {
    _subTotal.value = value;
  }

  bool? isAvailable;
  int? subQty;
  int? quantity;
  Product? cartItem;
}
