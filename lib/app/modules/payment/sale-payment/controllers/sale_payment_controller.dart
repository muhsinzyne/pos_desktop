import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/payment/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/navigation/sale_payment_nav.dart';
import 'package:posdelivery/models/requests/payment/add_sale_payment_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/message.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

class SalePaymentController extends BaseGetXController
    implements ISalePaymentController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  var salePaymentNavParams = SalePaymentNavParams().obs;
  RxBool disabledFormFiled = RxBool(false);

  final TextEditingController invoiceTotalAmount = TextEditingController();
  final TextEditingController dueAmount = TextEditingController();
  final TextEditingController paymentAmount = TextEditingController();
  final TextEditingController changeAmount = TextEditingController();
  final TextEditingController balanceAmount = TextEditingController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      salePaymentNavParams.value = Get.arguments;
      _autoFillData();
    }
    posDataProvider.salePaymentCallBack = this;
    super.onInit();
  }

  @override
  void onReady() {
    //UINotification.showLoading();
    super.onReady();
  }

  _autoFillData() {
    invoiceTotalAmount.text =
        salePaymentNavParams.value.invoiceTotal.toStringAsFixed(2);
    dueAmount.text =
        salePaymentNavParams.value.balanceAmount.toStringAsFixed(2);
    balanceAmount.text =
        salePaymentNavParams.value.balanceAmount.toStringAsFixed(2);
    paymentAmount.text = '0.0';
    changeAmount.text = '0.0';
  }

  double get payAmt {
    return double.tryParse(paymentAmount.text) ?? 0.0;
  }

  double get dueAmt {
    return double.tryParse(dueAmount.text) ?? 0.0;
  }

  double get balAmt {
    return double.tryParse(balanceAmount.text) ?? 0.0;
  }

  onChangedPaymentAmount() {
    if (paymentAmount.text != Constants.none) {
      // payment change
      var due = salePaymentNavParams.value.balanceAmount;
      try {
        var payment = double.tryParse(paymentAmount.text);
        var change = (due - payment!);
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

  actionConfirmOrder(BuildContext context) {
    if (balAmt != 0 && payAmt != dueAmt) {
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
    AddSalePaymentRequest addSalePaymentRequest = AddSalePaymentRequest();
    addSalePaymentRequest.saleId = salePaymentNavParams.value.id;
    addSalePaymentRequest.referenceNo = Constants.none;
    addSalePaymentRequest.amountPaid = payAmt.toStringAsFixed(2);
    addSalePaymentRequest.paidBy = Constants.paidByCash;
    posDataProvider.addSalePayment(addSalePaymentRequest);
  }

  @override
  onSalePaymentDone(CommonMessage cMess) {
    UINotification.hideLoading();
    UINotification.showNotification(color: Colors.green, title: cMess.message);
    Get.back();
  }

  @override
  onSalePaymentError(ErrorMessage errorMessage) {
    UINotification.hideLoading();
    UINotification.showNotification(
        color: Colors.red, title: errorMessage.message);
    Get.back();
  }
}
