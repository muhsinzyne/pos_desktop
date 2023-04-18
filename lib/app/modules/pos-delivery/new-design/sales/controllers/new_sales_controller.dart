import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/requests/pos/product_list.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';

class NewSalesScreenController extends BaseGetXController
    implements INewSalesScreenController {
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  //textcontroller
  final TextEditingController searchCtrl = TextEditingController();
  final logger = Logger();
  RxList<Product> productListTemp = RxList([]);
  RxList<Product> filteredProducts = RxList([]);
  RxList<Product> addedProducts = RxList([]);
  ProductListRequest productListRequest = ProductListRequest();

  void init() async {
    productListRequest.limit = 100;
    productListRequest.page = 1;
    productListRequest.warehouse_id = 1;
    deliveryDataProvider.getProductsSales(productListRequest);
  }

  void addToBasket(Product product) {
    var isAdded =
        addedProducts.firstWhereOrNull((element) => element.id == product.id);
    if (isAdded == null) {
      addedProducts.add(product);
    } else {
      Get.snackbar('Already in basek', 'Add another product');
    }
  }

  //lifecycle methods
  @override
  void onInit() async {
    deliveryDataProvider.newSalesCallBack = this;
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
  void onReady() async {
    super.onReady();
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
    filteredProducts.addAll(productListTemp);
    UINotification.hideLoading();
    if (productRes.isNotEmpty) {
      UINotification.showLoading();
      productListRequest.page = productListRequest.page! + 1;
      deliveryDataProvider.getProductsSales(productListRequest);
    }
  }

  @override
  onProductListError(ErrorMessage err) {
    // TODO: implement onProductListError
    throw UnimplementedError();
  }
}
