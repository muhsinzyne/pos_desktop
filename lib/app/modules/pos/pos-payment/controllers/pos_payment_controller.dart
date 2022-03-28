import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos/contract.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/navigation/print_view_nav.dart';
import 'package:posdelivery/models/requests/pos/sale_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/add_sale_response.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

class PosPaymentController extends BaseGetXController
    implements IPosPaymentController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();

  RxBool disabledFormFiled = RxBool(false);

  @override
  void onInit() {
    posDataProvider.posPaymentCallBack = this;
    super.onInit();
  }

  @override
  void onReady() {
    _autoFillForm();
    super.onReady();
  }

  final TextEditingController dueAmount = TextEditingController();
  final TextEditingController paymentAmount = TextEditingController();
  final TextEditingController changeAmount = TextEditingController();
  final TextEditingController balanceAmount = TextEditingController();

  double get balancePayment {
    return double.tryParse(balanceAmount.text)!;
  }

  double get duePayment {
    return double.tryParse(dueAmount.text)!;
  }

  actionConfirmOrder(BuildContext context) {
    if (balancePayment == duePayment || balancePayment > 0) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text('confirm_partial_payment'.tr),
          content: Text('are_you_sure_to_do_the_partial_payment'.tr),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Container(
                child: Text('cancel'.tr),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                _continuePayment();
              },
              child: Container(
                child: Text('confirm'.tr),
              ),
            ),
          ],
        ),
      );
    } else {
      _continuePayment();
    }
  }

  _continuePayment() {
    UINotification.showLoading();
    SaleRequest saleRequest = SaleRequest();
    saleRequest.test = '';
    saleRequest.customer = appService.cCustomer;
    saleRequest.warehouse = appService.cWareHouse;
    saleRequest.addItem = '';
    saleRequest.biller = appService.cBiller;
    saleRequest.posNote = '';
    saleRequest.staffNote = '';
    for (var element in appService.productPurchaseList) {
      saleRequest.productId.add(element.productId!);
      saleRequest.productType.add(element.itemType!);
      saleRequest.productCode.add(element.itemCode!);
      saleRequest.productName.add(element.itemName!);
      saleRequest.productOption.add('false');
      saleRequest.productComment.add('');
      saleRequest.serial.add('');
      saleRequest.productDiscount.add('0');
      if (element.rowProduct!.taxRate != null) {
        saleRequest.productTax.add(Constants.isTaxProduct);
      } else {
        saleRequest.productTax.add(Constants.nonTaxProduct);
      }
      saleRequest.productTax.add('1');
      // change to net price
      saleRequest.netPrice.add(element.netUnitProductPrice.toStringAsFixed(2));
      saleRequest.unitPrice.add(element.unitPrice.toStringAsFixed(2));
      saleRequest.realUnitPrice.add(element.unitPrice.toStringAsFixed(2));
      saleRequest.quantity.add(element.itemQty.toString());
      saleRequest.productUnit.add('');
      saleRequest.productBaseQuantity.add(element.baseQuantity!);
      //print(element.toJson());
    }
    saleRequest.amount.add(paymentAmount.text);

    var amountBalance = double.tryParse(changeAmount.text)!.abs() -
        (double.tryParse(balanceAmount.text)!);
    var amountBalanceString = amountBalance.toStringAsFixed(2);
    saleRequest.balanceAmount.add(amountBalanceString);
    saleRequest.paidBy.add('cash');
    saleRequest.ccNo.add('');
    saleRequest.payingGiftCardNo.add('');
    saleRequest.ccHolder.add('');
    saleRequest.chequeNo.add('');
    saleRequest.ccMonth.add('');
    saleRequest.ccYear.add('');
    saleRequest.ccType.add('');
    saleRequest.ccCvv2.add('');
    saleRequest.paymentNote.add('');
    saleRequest.orderTax = '0';
    saleRequest.discount = '0';
    saleRequest.shipping = '0';
    saleRequest.rPaidBy = 'cash';
    saleRequest.totalItems = appService.productPurchaseList.length.toString();
    var data = jsonEncode(saleRequest.toJson());
    posDataProvider.saleOrderRequest(saleRequest);
  }

  onChangedPaymentAmount() {
    if (paymentAmount.text != Constants.none) {
      // payment change
      var due = appService.grandTotalAmount;
      try {
        var payment = double.tryParse(paymentAmount.text);
        var change = (double.tryParse(due)! - payment!);
        if (change < 0) {
          changeAmount.text = change.toStringAsFixed(2);
          balanceAmount.text = '0';
        } else {
          balanceAmount.text = change.toStringAsFixed(2);
          changeAmount.text = '0';
        }
      } catch (e) {
        paymentAmount.text = '0';
      }
    } else {
      changeAmount.text = '0';
    }
  }

  _autoFillForm() {
    dueAmount.text = appService.grandTotalAmount;
    balanceAmount.text = appService.grandTotalAmount;
    paymentAmount.text = '0';
    changeAmount.text = '0';
  }

  @override
  onSaleDone(AddSaleResponse addSaleResponse) {
    appService.productPurchaseList.clear();
    UINotification.hideLoading();
    UINotification.showNotification(
      title: 'sales_completed'.tr,
      color: AppColors.greenIconColor,
    );
    PrintViewNavParams printViewNavParams = PrintViewNavParams();
    printViewNavParams.refId = addSaleResponse.data?.saleId.toString() ?? '0';
    Get.offAndToNamed(Routes.printView, arguments: printViewNavParams);
  }

  @override
  onSaleError(ErrorMessage err) {
    UINotification.hideLoading();
    UINotification.showNotification(
      title: err.message,
      color: Colors.red,
    );
  }
}
