import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-order/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-sales/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/delivery/requests/cart_product.dart';
import 'package:posdelivery/models/delivery/requests/order_add_request.dart';
import 'package:posdelivery/models/requests/pos/product_by_code.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/units.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';

class DeliverySalesScreenController extends BaseGetXController {
  // final TextEditingController productName = TextEditingController();
  RxList<CartProduct> cartItems = RxList([]);
  RxString totalProducts = "".obs;
  RxString totalQuantity = "".obs;
  RxString totalTax = "".obs;
  RxString subTotal = "".obs;
  RxString grandTotal = "".obs;
  // bool isOnline = false;
  late bool isOnline;
  CacheSembastDeliveryService sembastCache =
      Get.find<CacheSembastDeliveryService>();

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void calculateTotal() {
    totalQuantity.value =
        cartItems.fold<int>(0, (sum, item) => sum + item.quantity!).toString();
    subTotal.value = cartItems
        .fold<double>(0, (sum, item) => sum + item.subTotal!)
        .toStringAsFixed(2);
    totalTax.value = cartItems
        .fold<double>(0, (sum, item) => sum + item.tax!)
        .toStringAsFixed(2);
    grandTotal.value = cartItems
        .fold<double>(0, (sum, item) => sum + item.grandTotal!)
        .toStringAsFixed(2);
    totalProducts.value = cartItems.length.toString();
  }

  void deleteCartItem(int key, CartProduct item) async {
    cartItems.removeAt(key);
    await sembastCache.deleteCartProductData(item.key!);
    init();
  }

  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  // initialization for chrcking internet and cached data
  void init() async {
    cartItems.value = await sembastCache.getAllCartProducts();
    calculateTotal();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
