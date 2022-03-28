import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos/add-product/views/product_search.dart';
import 'package:posdelivery/app/modules/pos/contract.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/requests/pos/product_purchase_info.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/pos/units.dart';

class AddProductController extends BaseGetXController
    implements IAddProductController {
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
    product = Get.arguments;
    _autoFillForm();
  }

  @override
  void onReady() {
    super.onReady();
  }

  actionOnChangeUnit(String unit) {
    cUnit = product!.units!.firstWhere((element) => element.id == unit);
    cUnitName.value = cUnit.name!;
    pInfo.value.cUnit = cUnit;
    //Units baseUnit = product.units.firstWhere((element) => element.id == cUnit.baseUnit);
    //print(baseUnit.toJson());
    //print(cUnit.toJson());
    reCalculate();
  }

  actionOnChangeQty() {
    if (productQty.text != Constants.none) {
      var updateQty = int.tryParse(productQty.text);
      print(updateQty);
      pInfo.value.itemQty = updateQty!;
      reCalculate();
    }
  }

  actionAddAndNew(BuildContext context) {
    if (qtyAvailable) {
      appService.productPurchaseList.insert(0, pInfo.value);
      Get.back();
      showSearch(context: context, delegate: ProductSearch());
    } else {
      _triggerOutOfStock();
    }
  }

  actionAdd(BuildContext context) {
    if (qtyAvailable) {
      appService.productPurchaseList.insert(0, pInfo.value);
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
    productQty.text = Constants.no1;
    units.value = product!.units!;
    cUnit = product!.units!.first;
    rate.text = product!.row!.price!.toDouble().toStringAsFixed(2);
    cUnitName.value = cUnit.name!;
    pInfo.value.cUnit = cUnit;
    _calculations();
  }

  _calculations() {
    pInfo.value.uniqueId = appController.uuid.v4();
    pInfo.value.rowProduct = product!;
    pInfo.value.itemId = product!.itemId;
    pInfo.value.productId = product!.row!.id;
    pInfo.value.itemType = product!.row!.type;
    pInfo.value.comboItems = product!.comboItems;
    pInfo.value.itemPrice = product!.row!.price!;
    pInfo.value.itemQty = product!.row!.qty!;
    pInfo.value.itemAQty = product!.row!.quantity!;
    var data = jsonEncode(product!.row!.toJson());
    print(data);
    pInfo.value.itemTaxMethod = product!.row!.itemTaxMethod;
    pInfo.value.itemDs = double.tryParse(product!.row!.discount!)!;
    pInfo.value.itemDiscount = 0.0;
    pInfo.value.itemCode = product!.row!.code;
    pInfo.value.itemSerial = product!.row!.serial;
    pInfo.value.itemName = product!.row!.name;
    //pInfo.productUnit = product.row.unit as Units;
    pInfo.value.baseQuantity = product!.row!.baseQuantity.toString();
    pInfo.value.unitPrice = product!.row!.realUnitPrice!;
    pInfo.value.unitPrice = (pInfo.value.unitPrice - pInfo.value.itemDiscount);
    pInfo.value.avlQty = product!.row!.quantity;
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
          print("tax exclusive");
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
      print("/n /n /n here its coming");
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
          (pInfo.value.itemQty * pInfo.value.unitMulti)));
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
    print(pInfo.value.cUnit!.toJson());
  }
}
