import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-order/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/order_add_request.dart';
import 'package:posdelivery/models/requests/pos/product_by_code.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/units.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';

class DeliveryAddProductsOrderScreenController extends BaseGetXController
    implements IDeliveryAddProductsOrderScreenController {
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
  final TextEditingController price = TextEditingController();
  final TextEditingController unit = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  RxList<Units> units = RxList([]);
  RxBool isFile = false.obs;

  // bool isOnline = false;
  late bool isOnline;
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

  void calTotal() {
    if (quantity.text == "") {
      subTotal.value = "";
      taxAmount.value = "";
      totalAmount.value = "";
    }
    int qty = int.parse(quantity.text);
    int unt = int.parse(selectedUnit?.operationValue ?? "1");
    int cost = int.parse(price.text);
    subTotal.value = ((qty * unt) * cost).toString();
    double tax = double.parse(taxPercentage.value);
    int subAmount = int.parse(subTotal.value);
    taxAmount.value = ((tax / 100) * subAmount).toString();
    double taxA = double.parse(taxAmount.value);
    totalAmount.value = (taxA + subAmount).toString();
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
    if (isOnline) {
    } else {
      await sembastCache.setAddOrderFormData(orderAddRequest);
      Get.snackbar("internet",
          "No internet data will be added when internet is available");
    }
  }

  // initialization for chrcking internet and cached data
  void init() async {
    var productCode = Get.arguments["code"];
    logger.e(productCode);
    ProductByCodeRequest productByCodeRequest = ProductByCodeRequest();
    productByCodeRequest.code = int.parse(productCode);
    productByCodeRequest.customer_id = 2;
    productByCodeRequest.warehouse_id = 1;
    deliveryDataProvider.getProductByCode(productByCodeRequest);
    quantity.text = "0";
    quantity.addListener(() {
      calTotal();
    });
    // isOnline = await hasNetwork();
    // if (isOnline) {
    //   formData = await sembastCache.getAddExpenseFormData();
    //   logger.w(formData.length);
    //   if (formData.isNotEmpty) {
    //     var i;
    //     for (i = 0; i < formData.length; i++) {
    //       deliveryDataProvider.expenseAddRequestWithoutFile(formData[i]);
    //     }
    //     //delete cache after sending request
    //     await sembastCache.deleteAddExpenseFormData();
    //     Get.snauntckbar("Cached", "Cached $i requests is Saved Succesfully");
    //   }
    // }
  }

  void vaidate() async {
    if (productName.text.isNotEmpty &&
        price.text.isNotEmpty &&
        unit.text.isNotEmpty) {
      cacheOrInsert();
    } else {
      Get.snackbar("title", "enter all fields");
    }
  }

  @override
  void onInit() {
    deliveryDataProvider.deliveryAddProductsOrderCallBack = this;
    init();
    super.onInit();
  }

  @override
  void onReady() {
    UINotification.showLoading();
    super.onReady();
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

class UnitOption {
  final String key;
  final String fullName;

  UnitOption(this.key, this.fullName);
}
