import 'package:posdelivery/app/modules/pos-delivery/products-for-sales/contracts.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/requests/pos/product_list.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';

class DeliveryProductsForSalesScreenController extends BaseGetXController
    implements IDeliveryProductForSaleScreenController {
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
    deliveryDataProvider.getProductsSales(productListRequest);
  }

  @override
  void onInit() {
    deliveryDataProvider.deliveryProductForSaleCallBack = this;
    init();
    searchCtrl.addListener(() {
      List<Product> results = [];
      if (searchCtrl.text.isEmpty) {
        results = productListTemp;
      } else {
        results = filteredProducts
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
