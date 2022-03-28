import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos/add-product/views/product_search.dart';
import 'package:posdelivery/app/modules/pos/contract.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/requests/pos/product_purchase_info.dart';

class PosBillScreenController extends BaseGetXController implements IPosBillScreenController {
  actionSearch(BuildContext context) {
    showSearch(context: context, delegate: ProductSearch());
  }

  actionOnEditRequest(ProductPurchaseInfo purchaseInfo) async {
    await Future.delayed(Duration(milliseconds: 200));
    Get.toNamed(Routes.editProduct, arguments: purchaseInfo);
  }

  actionOnRemoveItemList(ProductPurchaseInfo purchaseInfo) async {
    await Future.delayed(Duration(milliseconds: 200));
    appService.productPurchaseList.removeWhere((element) => element.uniqueId == purchaseInfo.uniqueId);
    UINotification.showNotification(
      title: 'item_has_been_removed'.tr,
      color: Colors.red,
    );
  }

  clearBasket() {
    appService.productPurchaseList.clear();
    UINotification.showNotification(
      title: 'your_basket_has_been_cleared'.tr,
      color: Colors.green,
    );
  }

  onBackPressNotify() {
    UINotification.showNotification(
      title: 'please_press_one_more_time_clear_basket_and_go_back'.tr,
      color: Colors.deepOrange,
    );
  }

  actionToPayment() {
    if (appService.productPurchaseList.isEmpty) {
      Get.snackbar(
        'sorry'.tr,
        'your_cart_is_empty_please_add_minimum_one_product'.tr,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.toNamed(Routes.posPayment);
    }
  }
}
