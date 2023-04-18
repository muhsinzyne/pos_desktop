import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/cart_product.dart';
import 'package:posdelivery/models/response/pos/product.dart';

class NewBasketScreenController extends BaseGetXController {
  Logger logger = Logger();
  RxList<CartProduct> cartProducts = RxList([]);
  var total = 0.0.obs;

  void increment(int index) {
    cartProducts[index].quantity = 1 + cartProducts[index].quantity!;
    cartProducts[index].subTotal = cartProducts[index].quantity! *
        cartProducts[index].cartItem!.row!.price!.toDouble();
    cartProducts.refresh();
    calculateTotal();
  }

  void discrment(int index) {
    if (cartProducts[index].quantity! > 0) {
      cartProducts[index].quantity = cartProducts[index].quantity! - 1;
      cartProducts[index].subTotal = cartProducts[index].quantity! *
          cartProducts[index].cartItem!.row!.price!.toDouble();
      cartProducts.refresh();
      calculateTotal();
    }
  }

  void calculateTotal() {
    total.value =
        cartProducts.fold<double>(0, (sum, item) => sum + item.subTotal!);
  }

  void removeItem(int index) {
    cartProducts.removeAt(index);
    calculateTotal();
  }

  //lifecycle method
  @override
  void onInit() {
    List<Product> basketProduct = Get.arguments['addedProducts'];
    for (var element in basketProduct) {
      CartProduct temp = CartProduct();
      temp.cartItem = element;
      temp.itemId = element.id;
      temp.quantity = 1;
      temp.subTotal = double.parse(element.row!.price.toString());
      temp.grandTotal = temp.subTotal!;
      cartProducts.add(temp);
    }
    total.value =
        cartProducts.fold<double>(0, (sum, item) => sum + item.grandTotal!);

    super.onInit();
  }
}
