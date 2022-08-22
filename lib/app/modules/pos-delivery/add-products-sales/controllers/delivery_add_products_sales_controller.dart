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

class DeliveryAddProductsSalesScreenController extends BaseGetXController
    implements IDeliveryAddProductsSaleScreenController {
  final TextEditingController productName = TextEditingController();
  Units? selectedUnit;
  RxString discount = "".obs;
  RxString subTotal = "".obs;
  RxString taxPercentage = "".obs;
  RxString taxAmount = "".obs;
  RxString totalAmount = "".obs;
  String? warehouse;
  String? biller;
  String? totalItems;
  String? customer;
  String? totalQty;
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  RxList<Units> units = RxList([]);
  RxBool isFile = false.obs;
  CartProduct cartProduct = CartProduct();
  // dynamic isExists = false;
  Product temp = Product();
  // bool isOnline = false;
  late bool isOnline;
  bool isAddNew = false;
  dynamic isOrderExists = false;
  OrderAddRequest orderAddRequest = OrderAddRequest();
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
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

  // bool checkAlreadyExists() {
  // return await
  // }

  checkAvailableQuantity() {
    if (temp.row!.quantity! < int.parse(totalQty.toString())) {
      quantity.text = "0";
      subTotal.value = "0";
      totalQty = "0";
      totalAmount.value = "0";
      taxAmount.value = "0";
      cartProduct.tax = 0;
      cartProduct.quantity = 0;
      cartProduct.subQty = 0;
      Get.defaultDialog(
        title: "Not enough stock",
        middleText: "Add more stocks only ${temp.row!.quantity} is available ",
        middleTextStyle: TextStyle(color: Colors.black),
      );
    }
  }

  void calculateTotal() {
    if (quantity.text == "") {
      subTotal.value = "0";
      totalQty = "0";
      totalAmount.value = "0";
      cartProduct.tax = 0;
      cartProduct.quantity = 0;
      cartProduct.subQty = 0;
    } else {
      int qty = int.parse(quantity.text);
      int unt = int.parse(selectedUnit?.operationValue ?? "1");
      double cost = double.parse(price.text);
      subTotal.value = ((qty * unt) * cost).toString();
      double tax = double.parse(taxPercentage.value);
      double subAmount = double.parse(subTotal.value);
      taxAmount.value = ((tax / 100) * subAmount).toPrecision(1).toString();
      double taxA = double.parse(taxAmount.value);
      totalAmount.value = (taxA + subAmount).toString();
      totalQty = (qty * unt).toString();
      checkAvailableQuantity();
    }
  }

  void addAsExist() async {
    if (validate()) {
      if (!isAddNew) {
        isOrderExists = await sembastCache.getCartProductData(temp.itemId!);
        if (isOrderExists != null) {
          cartProduct = isOrderExists;
          cartProduct.subTotal =
              cartProduct.subTotal! + double.parse(subTotal.value);
          cartProduct.grandTotal =
              cartProduct.grandTotal! + double.parse(totalAmount.value);
          cartProduct.tax = cartProduct.tax! + double.parse(taxAmount.value);
          cartProduct.quantity =
              cartProduct.quantity! + int.parse(totalQty.toString());
          cartProduct.subQty = cartProduct.subQty! +
              int.parse(selectedUnit?.operationValue ?? "1");
          await sembastCache.updateCartProductData(cartProduct);
          Get.defaultDialog(
            title: "Added to cart ",
            middleText: "Succesfully added to cart as existing order",
            middleTextStyle: TextStyle(color: Colors.black),
          );
        } else {
          Get.defaultDialog(
            title: "Order does not exist",
            middleText:
                "this product is not exist in cart pls ADD pNEW order first",
            middleTextStyle: TextStyle(color: Colors.black),
          );
        }
      }
    } else {
      Get.snackbar("validation", "enter all fields");
    }
  }

  void addNew() async {
    if (validate()) {
      if (isAddNew) {
        cartProduct.cartItem = temp;
        cartProduct.itemId = temp.itemId;
        cartProduct.subTotal = double.parse(subTotal.value);
        cartProduct.grandTotal = double.parse(totalAmount.value);
        cartProduct.tax = double.parse(taxAmount.value);
        cartProduct.quantity = int.tryParse(totalQty.toString());
        cartProduct.subQty = int.parse(selectedUnit?.operationValue ?? "1");
        await sembastCache.setCartProductsData(cartProduct);
        Get.defaultDialog(
          title: "Added to cart ",
          middleText: "Succesfully added to cart as new order",
          middleTextStyle: TextStyle(color: Colors.black),
        );
      }
    } else {
      Get.snackbar("validation", "enter all fields");
    }
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

  void cacheOrInsert() async {
    await sembastCache.setCartProductsData(cartProduct);
    Get.defaultDialog(
      title: "Added to cart ",
      middleText: "Succesfully addedd to car",
      middleTextStyle: TextStyle(color: Colors.black),
    );
    // if (isOnline) {
    // } else {
    //   await sembastCache.setAddOrderFormData(orderAddRequest);
    //   Get.snackbar("internet", "No internet data will be added when internet is available");
    // }
  }

  // initialization for chrcking internet and cached data
  void init() async {
    int productCode = int.parse(Get.arguments["code"].toString());
    temp = await sembastCache.getProductData(
        Constants.deliveryProductsSales, productCode);
    // isExists = await sembastCache.getCartProductData(productCode);
    // if (isExists != null) {
    //   cartProduct = isExists;
    //   logger.e("exits");
    // }
    productName.text = temp.row!.name!;
    price.text = temp.row!.price.toString();
    units.addAll(temp.units!.toList());
    discount.value = temp.row!.discount!;
    taxPercentage.value = temp.taxRate?.rate ?? "0";
    quantity.addListener(() {
      calculateTotal();
    });
  }

  bool validate() {
    if (productName.text.isNotEmpty &&
        price.text.isNotEmpty &&
        quantity.text.isNotEmpty &&
        quantity.text != "0") {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    deliveryDataProvider.deliveryAddProductsSaleCallBack = this;
    init();
    super.onInit();
  }

  @override
  void onClose() {
    productName.dispose();
    price.dispose();
    quantity.dispose();
    super.onClose();
  }

  @override
  onProductDone(Product productRes) {
    productName.text = productRes.row!.name!;
    price.text = productRes.row!.price.toString();
    units.addAll(productRes.units!.toList());
    // logger.w(productRes.units![2].toJson());

    discount.value = productRes.row!.discount!;
    taxPercentage.value = productRes.taxRate?.rate ?? "0";
    taxAmount.value = productRes.row!.taxMethod.toString();
    warehouse = productRes.row?.warehouse;
    UINotification.hideLoading();
  }

  @override
  onProductError(ErrorMessage err) {
    logger.e(err);
  }
}
