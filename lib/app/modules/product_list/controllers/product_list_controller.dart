import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/home/controllers/home_controller.dart';
import 'package:posdelivery/app/modules/product_list/contracts.dart';
import 'package:posdelivery/app/modules/sales_point/controllers/sales_point_controller.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/providers/data/desktop_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_service.dart';
import 'package:logger/logger.dart';
import '../../../../models/response/pos/product.dart';

class ProductListController extends HomeController
    implements IProductListController {
  //TODO: Implement ProductListController

  DesktopDataProvider desktopDataProvider = Get.find<DesktopDataProvider>();
  CacheSembastService sembastService = Get.find<CacheSembastService>();
  RxList<Product> productList = RxList([]);
  // List<WarehouseProductsResponse> get products {
  //   List<WarehouseProductsResponse> dummy = [];
  //   for (var element in productList) {
  //     dummy.add(element);
  //   }
  //   return dummy;
  // }

  @override
  void onInit() {
    _fetchProducts();
    desktopDataProvider.productListCallBack = this;
    super.onInit();
  }

  _fetchProducts() async {
    productList.value = await sembastService.getAllProducts();
    // print(productList.length);
  }

  @override
  onWProductOffListDone(List<WarehouseProductsResponse> wPListRes) {
    // productList.value = wPListRes;
    UINotification.hideLoading();
  }

  @override
  onWProductOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }

  RxList<Product> selectedProducts = RxList([]);
  final ScrollController scrollControllerProducts = ScrollController();
  final RxString _subTotal = RxString("");
  RxBool paymentFlag = RxBool(true);

  addProductOnClick(Product value) {
    selectedProducts.add(value);
    checkQuantity(value);

    // _selectedProduct.value = value;
    // logger.wtf(_selectedProduct.value.label);
  }

  removeProduct(Product product) {
    selectedProducts.remove(product);
    bool status =
        selectedProducts.every((item) => item.row!.quantity != 0); // false
    if (status) {
      paymentFlag.value = true;
    }
  }

  // addProduct() {
  //   //logger.e(searchController)
  //   // Product? result = productList.firstWhereOrNull(
  //   //     (element) => element.row!.code == searchController.text);
  //   if (result != null) {
  //     selectedProducts.add(result);
  //     checkQuantity(result);
  //     searchController.text = "";
  //   } else {
  //     logger.e("not found");
  //   }
  // }
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  checkProductCode(String a) {
    var result =
        productList.firstWhereOrNull((element) => element.row!.code == a);
    if (result != null) {
      logger.e("found product");
    } else {
      logger.e("not found");
    }
  }

  checkQuantity(Product product) {
    if (product.row!.quantity == 0) {
      Get.defaultDialog(
        title: "Out of stock",
        middleText: "Add more stocks",
        backgroundColor: Colors.white,
        textCancel: "OK",
        titleStyle: TextStyle(color: Colors.black),
        middleTextStyle: TextStyle(color: Colors.black),
      );

      paymentFlag.value = false;
    }
  }

  // String getSubTotal(int index) {
  // int total = selectedProducts[index].row!.price!.toInt() *
  // selectedProducts[index].row!.qty!.toInt();
  // subTotal.value = total.toString();
  // return subTotal.value;
  // }

  checkAvailableQuantity(int index, String? value) {
    if (value!.isNotEmpty) {
      if (int.parse(value) > selectedProducts[index].row!.quantity!) {
        paymentFlag.value = false;
        Get.defaultDialog(
          title: "Not enough stock",
          middleText: "Add more stocks",
          backgroundColor: Colors.white,
          textCancel: "OK",
          titleStyle: TextStyle(color: Colors.black),
          middleTextStyle: TextStyle(color: Colors.black),
        );
      } else {
        selectedProducts[index].row!.qty = int.parse(value);
      }
    }
  }
}
