import 'dart:math';

import 'package:get/get.dart';
import 'package:posdelivery/app/modules/product_list/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/providers/data/desktop_data_provider.dart';

import '../../../../models/response/pos/product.dart';

class ProductListController extends BaseGetXController
    implements IProductListController {
  //TODO: Implement ProductListController

  DesktopDataProvider desktopDataProvider = Get.find<DesktopDataProvider>();
  RxList<WarehouseProductsResponse> productList = RxList([]);
  List<WarehouseProductsResponse> get products {
    List<WarehouseProductsResponse> dummy = [];
    for (var element in productList) {
      dummy.add(element);
    }
    return dummy;
  }

  @override
  void onInit() {
    desktopDataProvider.productListCallBack = this;
    super.onInit();
  }

  @override
  void onReady() {
    // _fetchProducts();
    super.onReady();
  }

  @override
  void onClose() {}

  @override
  onWProductOffListDone(List<WarehouseProductsResponse> wPListRes) {
    productList.value = wPListRes;
    UINotification.hideLoading();
  }

  @override
  onWProductOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }
}
