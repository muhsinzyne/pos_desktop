import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:posdelivery/app/modules/pos/contract.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/requests/pos/product_purchase_info.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/pos/units.dart';

class EditProductController extends BaseGetXController
    implements IEditProductController {
  bool dummyFalse = false;
  final productName = TextEditingController();
  final productQty = TextEditingController();
  final unit = TextEditingController();
  final rate = TextEditingController();

  Units cUnit = Units();
  RxList<Units> units = RxList([]);
  RxString cUnitName = RxString('');
  var pInfo = ProductPurchaseInfo().obs;
  Product? product;

  RxString infoSubTotal = RxString('');
  RxString infoItemDiscount = RxString('');
  RxString infoTaxRate = RxString('');
  RxString infoTaxVal = RxString('');
  RxString infoTotalAmount = RxString('');
  RxString totalTax = RxString('');

  @override
  void onInit() {
    super.onInit();
    pInfo.value = Get.arguments;
    product = pInfo.value.rowProduct;
    _autoFillForm();
  }

  @override
  void onReady() {
    super.onReady();
  }

  actionOnRemoveItemList() async {
    await Future.delayed(Duration(milliseconds: 200));
    appService.productPurchaseList
        .removeWhere((element) => element.uniqueId == pInfo.value.uniqueId);
    UINotification.showNotification(
      title: 'item_has_been_removed'.tr,
      color: Colors.red,
    );
    Get.back();
  }

  actionOnChangeUnit(String unit) {
    cUnit = product!.units!.firstWhere((element) => element.id == unit);
    cUnitName.value = cUnit.name!;
    pInfo.value.cUnit = cUnit;

    reCalculate();
  }

  actionOnChangeQty() {
    if (productQty.text != Constants.none) {
      var updateQty = int.tryParse(productQty.text);
      pInfo.value.itemQty = updateQty!;
      reCalculate();
    }
  }

  actionUpdate(BuildContext context) {
    if (qtyAvailable) {
      //ProductPurchaseInfo item = appService.productPurchaseList.firstWhere((element) => element.uniqueId == pInfo.value.uniqueId);
      var index = appService.productPurchaseList
          .indexWhere((element) => element.uniqueId == pInfo.value.uniqueId);
      appService.productPurchaseList[index] = pInfo.value;
      //item = pInfo.value;
      Get.back();
    } else {
      _triggerOutOfStock();
    }
  }

  bool get qtyAvailable {
    if (pInfo.value.unitMulti * pInfo.value.itemQty > pInfo.value.avlQty!) {
      return false;
    }
    return true;
  }

  _triggerOutOfStock() {
    UINotification.showNotification(
      title: 'out_of_stock',
      color: Colors.red,
    );
  }

  onChangeRate() {
    if (rate.text != Constants.none) {
      var updateRate = double.tryParse(rate.text);
      pInfo.value.unitPrice = updateRate!;
      reCalculate();
    }
  }

  _autoFillForm() {
    productName.text = product!.row!.name!;
    productQty.text = pInfo.value.itemQty.toString();
    units.value = product!.units!;
    cUnit = pInfo.value.cUnit!;
    cUnitName.value = cUnit.name!;
    rate.text = product!.row!.price!.toDouble().toStringAsFixed(2);
    _calculations();
  }

  _calculations() {
    reCalculate();
  }

  void reCalculate() {
    var taxVal = 0.0;
    var taxRate = '';
    pInfo.value.unitMulti = 1;
    pInfo.value.productTax = 0;
    if (product!.taxRate != null) {
      // local variables
      var unitPrice = pInfo.value.unitPrice;
      var tax = double.tryParse(product!.taxRate!.rate!);

      if (product!.taxRate!.type == Constants.taxTypePercentage) {
        if (product!.row!.itemTaxMethod == Constants.taxInclusive) {
          // tax inclusive
          taxVal = ((unitPrice * tax!) / (100 + tax));
          taxRate = tax.toStringAsFixed(2) + '%';
        } else {
          taxVal = ((unitPrice * tax!) / 100);
          taxRate = tax.toStringAsFixed(2) + '%';
        }
      } else if (product!.taxRate!.type == Constants.taxTypeFlat) {
        taxVal = tax!;
        taxRate = tax.toString();
      }

      if (cUnit.operator != null && cUnit.operationValue != null) {
        pInfo.value.unitMulti =
            (pInfo.value.unitMulti * int.tryParse(cUnit.operationValue!)!);
      }
      pInfo.value.productTax +=
          (taxVal * (pInfo.value.itemQty * pInfo.value.unitMulti));
    }
    if (pInfo.value.itemTaxMethod == Constants.taxInclusive) {
      pInfo.value.itemPrice = (pInfo.value.unitPrice - taxVal);
    } else {
      pInfo.value.itemPrice = pInfo.value.unitPrice;
    }

    pInfo.value.taxVal = taxVal;
    pInfo.value.taxRate = taxRate;

    pInfo.value.unitPrice = pInfo.value.unitPrice + pInfo.value.itemDiscount;
    if (product!.row!.itemTaxMethod == Constants.taxInclusive) {
      pInfo.value.subTotal = (pInfo.value.unitPrice *
          (pInfo.value.itemQty * pInfo.value.unitMulti));
      pInfo.value.totalAmount = pInfo.value.subTotal;
    } else {
      pInfo.value.subTotal = ((pInfo.value.unitPrice *
              (pInfo.value.itemQty * pInfo.value.unitMulti)) -
          pInfo.value.productTax);
      pInfo.value.totalAmount = pInfo.value.subTotal + pInfo.value.productTax;
    }

    pInfo.value.totalTax =
        pInfo.value.taxVal * (pInfo.value.itemQty * pInfo.value.unitMulti);

    // assign data
    infoSubTotal.value = pInfo.value.subTotal.toStringAsFixed(2);
    infoItemDiscount.value = pInfo.value.itemDiscount.toStringAsFixed(2);
    infoTotalAmount.value = pInfo.value.totalAmount.toStringAsFixed(2);
    infoTaxVal.value = pInfo.value.taxVal.toStringAsFixed(2);
    infoTaxRate.value = pInfo.value.taxRate!;
    totalTax.value = pInfo.value.totalTax.toStringAsFixed(2);
  }
}
