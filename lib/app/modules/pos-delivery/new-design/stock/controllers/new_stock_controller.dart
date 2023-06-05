import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/stock/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/requests/pos/product_list.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/models/delivery/requests/cart_product.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/sale_item.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'dart:convert' show utf8;
class NewStockScreenController extends BaseGetXController
    implements INewStockScreenController {
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  //textcontroller
  final TextEditingController searchCtrl = TextEditingController();
  final logger = Logger();
  RxList<Product> productListTemp = RxList([]);
  RxList<Product> filteredProducts = RxList([]);
  RxList<CartProduct> addedProducts = RxList([]);
  ProductListRequest productListRequest = ProductListRequest();

  void init() async {
    productListRequest.limit = 100;
    productListRequest.page = 1;
    productListRequest.warehouse_id = 1;
    deliveryDataProvider.getProductsStock(productListRequest);
  }


  //lifecycle methods
  @override
  void onInit() async {
    deliveryDataProvider.newStockCallBack = this;
    init();
    searchCtrl.addListener(() {
      List<Product> results = [];
      if (searchCtrl.text.isEmpty) {
        results = productListTemp;
      } else {
        results = productListTemp
            .where((product) => product.label!
                .toLowerCase()
                .contains(searchCtrl.text.toLowerCase()))
            .toList();
      }
      filteredProducts.value = results;
    });

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(milliseconds: 10));
    UINotification.showLoading();
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }

  //contracts
  @override
  onProductListDone(List<Product> productRes) {
    productListTemp.addAll(productRes);
    filteredProducts.addAll(productRes);
    if (productRes.isNotEmpty) {
      productListRequest.page = productListRequest.page! + 1;
      deliveryDataProvider.getProductsStock(productListRequest);
    } else {
      UINotification.hideLoading();
    }
  }

  @override
  onProductListError(ErrorMessage err) {
    Logger().e(err.message);
    UINotification.hideLoading();
  }
}
