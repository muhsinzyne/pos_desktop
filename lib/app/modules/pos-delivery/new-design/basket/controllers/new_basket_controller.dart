import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/basket/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';
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
import 'package:posdelivery/services/app_service.dart';

class NewBasketScreenController extends BaseGetXController
    implements INewSalePaymentController {
  Logger logger = Logger();
  NewStoreScreenController controller = Get.find<NewStoreScreenController>();
  RxList<CartProduct> cartProducts = RxList([]);
  var total = 0.0.obs;
  final AppService _appService = Get.find<AppService>();
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  RxString biller = "".obs;
  String totalItems = "";
  _continuePayment() async {
    UINotification.showLoading();
    SaleRequest saleRequest = SaleRequest();
    saleRequest.test = '';
    saleRequest.customer = controller.selectedStore.id;
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
        // saleRequest.productTax.add(element.taxR.toStringAsFixed(2));
      } else {
        saleRequest.productTax.add(Constants.nonTaxProduct);
      }
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
    saleRequest.amount.add(total.toString());
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
    // saleRequest.orderTax = totalTax;
    saleRequest.discount = '0';
    saleRequest.shipping = '0';
    saleRequest.rPaidBy = 'cash';
    saleRequest.totalItems = totalItems;
    deliveryDataProvider.saleOrderRequest(saleRequest);
  }

  void completeSale() {
    if (cartProducts.isNotEmpty) {
      _continuePayment();
    } else {
      Get.snackbar("empty", "the basket is empty");
    }
  }

  void increment(int index) {
    cartProducts[index].quantity = 1 + cartProducts[index].quantity!;
    cartProducts[index].subTotal = cartProducts[index].quantity! *
        cartProducts[index].cartItem!.row!.price!.toDouble();
    cartProducts.refresh();
    calculateTotal();
  }

  void discrment(int index) {
    if (cartProducts[index].quantity! > 0) {
      cartProducts[index].quantity = cartProducts[index].quantity! - 1;
      cartProducts[index].subTotal = cartProducts[index].quantity! *
          cartProducts[index].cartItem!.row!.price!.toDouble();
      cartProducts.refresh();
      calculateTotal();
    }
  }

  void calculateTotal() {
    Logger().w(_appService.myInfoResponse.firstName);
    total.value =
        cartProducts.fold<double>(0, (sum, item) => sum + item.subTotal!);
    totalItems = cartProducts
        .fold<int>(0, (sum, item) => sum + item.quantity!)
        .toString();
  }

  void removeItem(int index) {
    cartProducts.removeAt(index);
    calculateTotal();
  }

  //lifecycle method
  @override
  void onInit() {
    deliveryDataProvider.newSalePaymentCallBack = this;
    biller.value =
        '${_appService.myInfoResponse.firstName!}  ${_appService.myInfoResponse.lastName!}';
    List<CartProduct> basketProduct = Get.arguments['addedProducts'];
    cartProducts.value = basketProduct;
    // for (var element in basketProduct) {
    //   CartProduct temp = CartProduct();
    //   temp.cartItem = element;
    //   temp.itemId = element.id;
    //   temp.quantity = 1;
    //   temp.subTotal = double.parse(element.row!.price.toString());
    //   temp.grandTotal = temp.subTotal!;
    //   cartProducts.add(temp);
    // }
    total.value =
        cartProducts.fold<double>(0, (sum, item) => sum + item.grandTotal!);

    super.onInit();
  }

  @override
  onSaleDone(AddSaleResponse addSaleResponse) {
    addSaleResponse.data!.saleId;
    UINotification.hideLoading();

    PrintViewNavParams printViewNavParams = PrintViewNavParams();
    printViewNavParams.refId = addSaleResponse.data?.saleId.toString() ?? '0';
    Get.offAndToNamed(Routes.newCompleteSale, arguments: printViewNavParams);
  }

  @override
  onSaleError(ErrorMessage err) {
    // TODO: implement onSaleError
    throw UnimplementedError();
  }
}
