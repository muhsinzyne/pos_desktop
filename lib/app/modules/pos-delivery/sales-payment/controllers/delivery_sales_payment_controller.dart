import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/sales-payment/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/delivery/requests/cart_product.dart';
import 'package:posdelivery/models/navigation/print_view_nav.dart';
import 'package:posdelivery/models/requests/pos/sale_request.dart';
import 'package:posdelivery/models/response/pos/add_sale_response.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/providers/local/pdf_invoice_provider.dart';
import 'package:posdelivery/services/app_service.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';

class DeliverySalesPaymentScreenController extends BaseGetXController
    implements IDeliverySalePaymentController {
  final TextEditingController totalPayableAmount = TextEditingController();
  final TextEditingController paymentAmount = TextEditingController();
  final TextEditingController changeAmount = TextEditingController();
  final TextEditingController balanceAmount = TextEditingController();
  final TextEditingController dueDate = TextEditingController();
  RxList<CartProduct> cartProducts = RxList([]);
  RxBool isDue = RxBool(false);
  String totalTax = '';
  String totalItems = '';
  late bool isOnline;
  int? id;
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  final AppService _appService = Get.find<AppService>();

  CacheSembastDeliveryService sembastCache =
      Get.find<CacheSembastDeliveryService>();
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  void init() async {
    isOnline = await hasNetwork();
    // id = int.parse(Get.arguments["key"].toString());
    cartProducts.value = await sembastCache.getAllCartProducts();
    totalPayableAmount.text = cartProducts
        .fold<double>(0, (sum, item) => sum + item.grandTotal!)
        .toStringAsFixed(2)
        .toString();

    totalTax = cartProducts
        .fold<double>(0, (sum, item) => sum + item.tax!)
        .toStringAsFixed(2);
    totalItems = cartProducts
        .fold<int>(0, (sum, item) => sum + item.quantity!)
        .toString();
    logger.e(totalTax);
    // dueAmount.text = cartProduct.grandTotal.toString();
    if (isOnline) {
      List<SaleRequest> formData = await sembastCache.getAllAddSaleFormData();
      if (formData.isNotEmpty) {
        var i;
        for (i = 0; i < formData.length; i++) {
          deliveryDataProvider.saleOrderRequestOffline(formData[i]);
        }
        await sembastCache.deleteAddSaleFormData();
        Get.snackbar("Cached", "Cached $i requests is Saved Succesfully");
        sembastCache.deleteAllCartProductsData();
      }
    }
  }

  double get balancePayment {
    return double.tryParse(balanceAmount.text)!;
  }

  double get duePayment {
    return double.tryParse(totalPayableAmount.text) ?? 0;
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

  _continuePayment() async {
    UINotification.showLoading();
    SaleRequest saleRequest = SaleRequest();
    saleRequest.test = '';
    saleRequest.customer = "2";
    // saleRequest.warehouse = appService.cWareHouse;
    saleRequest.warehouse = "1";
    saleRequest.addItem = '';
    // saleRequest.biller = appService.cBiller;
    saleRequest.biller = "1";
    saleRequest.posNote = '';
    saleRequest.staffNote = '';
    for (var element in cartProducts) {
      saleRequest.productId.add(element.cartItem!.row!.id!);
      saleRequest.productType.add(element.cartItem!.row!.type!);
      saleRequest.productCode.add(element.cartItem!.row!.code!);
      saleRequest.productName.add(element.cartItem!.row!.name!);
      saleRequest.productOption.add('false');
      saleRequest.productComment.add('');
      saleRequest.serial.add('');
      saleRequest.productDiscount.add('0');
      if (element.cartItem!.taxRate != null) {
        saleRequest.productTax.add(Constants.isTaxProduct);
        saleRequest.productTax.add(element.tax!.toStringAsFixed(2));
      } else {
        saleRequest.productTax.add(Constants.nonTaxProduct);
      }
      // saleRequest.productTax.add('1');
      // change to net price
      saleRequest.netPrice.add(element.grandTotal!.toStringAsFixed(2));
      saleRequest.unitPrice.add((element.cartItem!.row!.price! -
              double.parse(element.cartItem!.row!.discount!))
          .toStringAsFixed(2));
      saleRequest.realUnitPrice
          .add(element.cartItem!.row!.realUnitPrice!.toStringAsFixed(2));
      saleRequest.quantity.add(element.quantity.toString());
      saleRequest.productUnit.add('');
      saleRequest.productBaseQuantity
          .add(element.cartItem!.row!.baseQuantity!.toString());
      //print(element.toJson());
    }
    // saleRequest.amount.add(paymentAmount.value.text);
    saleRequest.amount.add(paymentAmount.text);
    // var amountBalance = double.tryParse(changeAmount.text)!.abs() -
    //     (double.tryParse(balanceAmount.text)!);
    // var amountBalanceString = amountBalance.toStringAsFixed(2);
    saleRequest.balanceAmount.add(balancePayment.toString());
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
    saleRequest.orderTax = totalTax;
    saleRequest.discount = '0';
    saleRequest.shipping = '0';
    saleRequest.rPaidBy = 'cash';
    saleRequest.totalItems = totalItems;
    deliveryDataProvider.saleOrderRequest(saleRequest);
    // // UINotification.showLoading();
    // SaleRequest saleRequest = SaleRequest();
    // saleRequest.test = '';
    // saleRequest.due_date = dueDate.text;
    // saleRequest.customer = "2";
    // // saleRequest.warehouse = appService.cWareHouse;
    // saleRequest.warehouse = "1";
    // saleRequest.addItem = '';
    // // saleRequest.biller = appService.cBiller;
    // saleRequest.biller = "1";
    // saleRequest.posNote = '';
    // saleRequest.staffNote = '';
    // saleRequest.productId.add(cartProduct.cartItem!.row!.id!);
    // saleRequest.productType.add(cartProduct.cartItem!.row!.type!);
    // saleRequest.productCode.add(cartProduct.cartItem!.row!.code!);
    // saleRequest.productName.add(cartProduct.cartItem!.row!.name!);
    // saleRequest.productOption.add('false');
    // saleRequest.productComment.add('');
    // saleRequest.serial.add('');

    // saleRequest.productDiscount.add('0');
    // if (cartProduct.cartItem!.taxRate != null) {
    //   saleRequest.productTax.add(Constants.isTaxProduct);
    // } else {
    //   saleRequest.productTax.add(Constants.nonTaxProduct);
    // }
    // // change to net price
    // saleRequest.netPrice.add(cartProduct.grandTotal!.toStringAsFixed(2));
    // saleRequest.unitPrice.add((cartProduct.cartItem!.row!.price! -
    //         double.parse(cartProduct.cartItem!.row!.discount!))
    //     .toStringAsFixed(2));
    // saleRequest.realUnitPrice
    //     .add(cartProduct.cartItem!.row!.realUnitPrice!.toStringAsFixed(2));
    // saleRequest.quantity.add(cartProduct.quantity.toString());
    // saleRequest.productUnit.add('');
    // saleRequest.productBaseQuantity
    //     .add(cartProduct.cartItem!.row!.baseQuantity!.toString());
    // //print(element.toJson());
    // saleRequest.amount.add(paymentAmount.value.text);

    // var amountBalance = double.tryParse(changeAmount.text)!.abs() -
    //     (double.tryParse(balanceAmount.text)!);
    // var amountBalanceString = amountBalance.toStringAsFixed(2);
    // saleRequest.balanceAmount.add("0");
    // saleRequest.paidBy.add('cash');
    // saleRequest.ccNo.add('');
    // saleRequest.payingGiftCardNo.add('');
    // saleRequest.ccHolder.add('');
    // saleRequest.chequeNo.add('');
    // saleRequest.ccMonth.add('');
    // saleRequest.ccYear.add('');
    // saleRequest.ccType.add('');
    // saleRequest.ccCvv2.add('');
    // saleRequest.paymentNote.add('');
    // saleRequest.orderTax = '0';
    // saleRequest.discount = '0';
    // saleRequest.shipping = '0';
    // saleRequest.rPaidBy = 'cash';
    // saleRequest.totalItems = cartProduct.quantity.toString();
    // // var data = jsonEncode(saleRequest.toJson());
    // isOnline = await hasNetwork();
    // if (isOnline) {
    //   logger.e("online");
    //   deliveryDataProvider.saleOrderRequest(saleRequest);
    // } else {
    //   logger.e("offline");
    //   await sembastCache.setAddSaleFormData(saleRequest);
    //   sembastCache.deleteCartProductData(id!);

    //   Get.snackbar("Offline",
    //       "No internet data will be added when internet is available");
    //   Get.offAndToNamed(Routes.deliverySales);
    // }
  }

  void calculate() {
    double due = double.parse(totalPayableAmount.text);
    double pay = double.parse(paymentAmount.text);
    // int pay = 276;
    if (due > pay) {
      balanceAmount.text = (due - pay).toStringAsFixed(2);
      changeAmount.text = "0";
    } else {
      balanceAmount.text = "0";
      changeAmount.text = (pay - due).toStringAsFixed(2);
    }
    if (balancePayment == duePayment || balancePayment > 0) {
      isDue.value = true;
    } else {
      isDue.value = false;
    }
  }

  @override
  void onInit() {
    deliveryDataProvider.deliverySalePaymentCallBack = this;
    // logger.e(_appService.cWareHouse);
    init();
    paymentAmount.addListener(() {
      calculate();
    });
    super.onInit();
  }

  @override
  void onClose() {
    totalPayableAmount.dispose();
    paymentAmount.dispose();
    changeAmount.dispose();
    balanceAmount.dispose();
    dueDate.dispose();
    super.onClose();
  }

  @override
  onSaleDone(AddSaleResponse addSaleResponse) {
    addSaleResponse.data!.saleId;
    sembastCache.deleteAllCartProductsData();
    Get.snackbar("Saved", "Your request saved succesfully");

    UINotification.hideLoading();

    PrintViewNavParams printViewNavParams = PrintViewNavParams();
    printViewNavParams.refId = addSaleResponse.data?.saleId.toString() ?? '0';
    Get.offAndToNamed(Routes.deliverySaleInvoice,
        arguments: printViewNavParams);
  }

  @override
  onSaleError(ErrorMessage err) {
    logger.e(err);
  }

  @override
  onSaleDoneOffline(AddSaleResponse addSaleResponse) {}
}
