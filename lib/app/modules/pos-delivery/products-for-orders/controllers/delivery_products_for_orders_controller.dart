import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/requests/pos/product_list.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';

import '../contracts.dart';

class DeliveryProductsForOrdersScreenController extends BaseGetXController
    implements IDeliveryProductForOrderScreenController {
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();

  final TextEditingController searchCtrl = TextEditingController();
  String? category;
  final TextEditingController amount = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController address = TextEditingController();
  // bool isOnline = false;
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  RxList<Product> productListTemp = RxList([]);

  List<Product> temp = [];

  RxList<Product> filteredProducts = RxList([]);

  // initialization for chrcking internet and cached data
  void init() async {
    ProductListRequest productListRequest = ProductListRequest();
    productListRequest.limit = 100;
    productListRequest.page = 1;
    productListRequest.warehouse_id = 1;
    deliveryDataProvider.getProducts(productListRequest);
  }

  @override
  void onInit() {
    deliveryDataProvider.deliveryProductForOrderCallBack = this;
    init();
    searchCtrl.addListener(() {
      logger.e(searchCtrl.text);
      List<Product> results = [];
      if (searchCtrl.text.isEmpty) {
        // if the search field is empty or only contains white-space, we'll display all users
        results = productListTemp;
      } else {
        results = filteredProducts
            .where((product) => product.label!
                .toLowerCase()
                .contains(searchCtrl.text.toLowerCase()))
            .toList();
        // we use the toLowerCase() method to make it case-insensitive
      }
      filteredProducts.value = results;
      // update(filteredProducts);
    });

    super.onInit();
  }

  @override
  void onReady() {
    UINotification.showLoading();
    super.onReady();
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    amount.dispose();
    address.dispose();
    super.onClose();
  }

  @override
  onProductListDone(List<Product> productRes) {
    // temp.addAll(productRes);
    // logger.e(temp[0].label);
    productListTemp.addAll(productRes);
    filteredProducts.addAll(productListTemp);
    UINotification.hideLoading();
  }

  @override
  onProductListError(ErrorMessage err) {
    logger.e(err.message);
  }
}
