import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/helpers/string.dart';
import 'package:posdelivery/app/modules/sales_point/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/cache_db_path.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/requests/customer/customer_add_request.dart';
import 'package:posdelivery/models/requests/pos/cart_product.dart';
import 'package:posdelivery/models/requests/pos/product_purchase_info.dart';
import 'package:posdelivery/models/requests/pos/sale_request.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/customer/customer_group.dart';
import 'package:posdelivery/models/response/customer/customer_price_group_response.dart';
import 'package:posdelivery/models/response/customer/price_group.dart';
import 'package:posdelivery/models/response/desktop/customer_group.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/add_sale_response.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/providers/data/desktop_data_provider.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/services/app_service.dart';
import 'package:posdelivery/services/cache/cache_sembast_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';

class SalesPointController extends BaseGetXController
    implements ISalesPointController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  DesktopDataProvider desktopDataProvider = Get.find<DesktopDataProvider>();
  CacheSembastService sembestCatch = Get.find<CacheSembastService>();

  final addFromKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController pCode = TextEditingController();
  final TextEditingController cName = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController vatNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController custom1 = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final custGrp = RxString("");
  final pGrp = RxString("");
  AppService appService = Get.find<AppService>();
  CacheService cache = Get.find<CacheService>();
  final RxString _cWareHouseName = RxString('');
  final RxString _cBillerName = RxString('');
  final RxString cCustomer = RxString('');
  final RxString selectedCustomerName = RxString('');
  final RxBool scanner = RxBool(false);
  RxDouble cartTotal = RxDouble(0);
  RxDouble totalPayable = RxDouble(0);
  var customerPriceGroup = CustomerPriceGroupsResponse().obs;
  var cCustomerGroup = CustomerGroups().obs;
  var cPriceGroup = PriceGroups().obs;
  MyInfoResponse info = MyInfoResponse();
  RxList<Product> product = RxList([]);
  // RxList<Product> selectedProducts = RxList([]);
  // var selectedProducts = RxList<ProductPurchaseInfo>();

  RxList<CartProduct> selectedProducts = RxList([]);
  final ScrollController scrollController = ScrollController();
  final RxString _subTotal = RxString("");
  //final _selectedProduct = Product().obs;
  String get cWareHouseName => _cWareHouseName.value;

  //Product get selectedProduct => _selectedProduct.value;
  RxBool paymentFlag = RxBool(true);

  final searchController = TextEditingController();
  @override
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  // RxList<CustomerGroupResponse> custGrps = RxList([]);
  RxList<CustomerListOffResponse> cusList = RxList([]);
  // List<String> get customerGroups {
  //   List<String> dummy = [];
  //   for (var element in custGrps) {
  //     dummy.add(element.name.toString());
  //   }
  //   return dummy;
  // }

  TextEditingController get textController {
    TextEditingController cntrl = TextEditingController();
    cntrl.addListener(() {
      logger.e(textController.text);
    });
    return cntrl;
  }

  List<String> get customerListString {
    List<String> dummyList = [];
    for (var element in cusList) {
      // dummyList.add("[${element.id.toString()}]  ${element.name.toString()}");
      dummyList.add(element.name.toString());
    }
    return dummyList;
  }

  List<String> get productListString {
    // logger.wtf("message");
    List<String> dummyList = [];
    for (var element in product) {
      //dummyList
      //  .add("[${element.itemId.toString()}]  ${element.label.toString()}");
      dummyList.add(element.row!.name.toString());
    }
    //logger.e(dummyList.first);
    return dummyList;
  }

  // RxList<Product> product = RxList([]);
  RxList<WarehouseListResponse> wLsit = RxList([]);
  List<String> get warehouses {
    List<String> wh = [];
    for (var x in wLsit) {
      wh.add(x.name.toString());
    }
    return wh;
  }

  List<String> get pGrps {
    List<String> dummy = [];
    for (var element in customerPriceGroup.value.priceGroups!) {
      dummy.add(element.name.toString());
    }
    return dummy;
  }

  void changeCustomer(String value) {
    cCustomer.value = StringHelper.splitFromBracket(value);
    appService.cCustomer = cCustomer.value;
  }

  void changeWarehouse(String value) {
    _cWareHouseName.value = value;
  }

  void changeCustGroup(String value) {
    custGrp.value = value;
  }

  onChangeCustomerGroup(CustomerGroups value) {
    cCustomerGroup.value = value;
  }

  onChangePriceGroup(PriceGroups value) {
    cPriceGroup.value = value;
  }

  addProductOnClick(Product value) {
    if (selectedProducts.any((element) => element.itemId == value.itemId)) {
      Get.defaultDialog(
        title: "Already in cart",
        middleText: "Please change the quantity in cart",
        backgroundColor: Colors.white,
        textCancel: "OK",
        titleStyle: TextStyle(color: Colors.black),
        middleTextStyle: TextStyle(color: Colors.black),
      );
      //   int index = selectedProducts
      //       .indexWhere((element) => element.itemId == value.itemId);
      //   value.row!.qty! + 1;
      //   Product temp = value;
      //   selectedProducts.removeAt(index);
      //   selectedProducts.insert(index, temp);
    } else {
      var product = CartProduct();
      // cartTotal.value += double.parse(value.row!.price!.toString());
      product.itemId = value.itemId;
      product.subTotal = double.parse(value.row!.price!.toString());
      product.subQty = 1;
      product.isAvailable = true;
      product.quantity = value.row!.quantity;
      product.cartItem = value;
      selectedProducts.add(product);
      calculateTotal();
    }
    checkQuantity(value);
    searchController.text = "";
    // _selectedProduct.value = value;
    // logger.wtf(_selectedProduct.value.label);
  }

  removeProduct(CartProduct product) {
    selectedProducts.remove(product);
    bool status = selectedProducts.every((item) => item.quantity != 0); // false
    if (status) {
      paymentFlag.value = true;
    }
    calculateTotal();
  }

  addProduct() {
    //logger.e(searchController)
    Product? value = product.firstWhereOrNull(
        (element) => element.row!.code == searchController.text);
    if (value != null) {
      // cartTotal.value += double.parse(value.row!.price!.toString());
      var product = CartProduct();
      product.itemId = value.itemId;
      product.subTotal = double.parse(value.row!.price!.toString());
      product.subQty = 1;
      product.isAvailable = true;
      product.quantity = value.row!.quantity;
      product.cartItem = value;
      selectedProducts.add(product);
      checkQuantity(value);
      calculateTotal();
      searchController.text = "";
    } else {
      logger.e("not found");
    }
  }

  checkProductCode(String a) {
    var result = product.firstWhereOrNull((element) => element.row!.code == a);
    if (result != null) {
      logger.e("found product");
    } else {
      logger.e("not found");
    }
  }

  checkQuantity(Product product) {
    if (product.row!.quantity == 0) {
      Get.defaultDialog(
        title: "Out of stock",
        middleText: "Add more stocks",
        backgroundColor: Colors.white,
        textCancel: "OK",
        titleStyle: TextStyle(color: Colors.black),
        middleTextStyle: TextStyle(color: Colors.black),
      );
      removeProduct(selectedProducts
          .firstWhere((cartItem) => cartItem.cartItem!.id == product.id));
      paymentFlag.value = checkAvailability();
    }
  }

  // String getSubTotal(int index) {
  // int total = selectedProducts[index].row!.price!.toInt() *
  // selectedProducts[index].row!.qty!.toInt();
  // subTotal.value = total.toString();
  // return subTotal.value;
  // }

  checkAvailableQuantity(int index, String? value) {
    if (value!.isNotEmpty) {
      if (int.parse(value) > selectedProducts[index].cartItem!.row!.quantity!) {
        paymentFlag.value = false;
        selectedProducts[index].isAvailable = false;
        Get.defaultDialog(
          title: "Not enough stock",
          middleText: "Add more stocks",
          backgroundColor: Colors.white,
          textCancel: "OK",
          titleStyle: TextStyle(color: Colors.black),
          middleTextStyle: TextStyle(color: Colors.black),
        );
      } else {
        int _qty = int.parse(value);
        selectedProducts[index].subQty = _qty;
        selectedProducts[index].isAvailable = true;
        selectedProducts[index].subTotal =
            selectedProducts[index].cartItem!.row!.price!.toDouble() * _qty;
        calculateTotal();
        paymentFlag.value = checkAvailability();
      }
    } else {
      Get.defaultDialog(
        title: "Quantity cannot be zero",
        middleText: "Please change the quantity in cart or remove the product",
        backgroundColor: Colors.white,
        textCancel: "OK",
        titleStyle: TextStyle(color: Colors.black),
        middleTextStyle: TextStyle(color: Colors.black),
      );
      calculateTotal();
      // removeProduct(selectedProducts[index]);
    }
  }

  @override
  void onInit() {
    // posDataProvider.salePointCallBack = this;
    desktopDataProvider.salePointCallBack = this;
    _cWareHouseName.value = appService.myInfoResponse.cWareHouse.name ?? '';
    _cBillerName.value = appService.myInfoResponse.cBiller.name ?? '';
    appService.cWareHouse = appService.myInfoResponse.cWareHouse.id!;
    appService.cBiller = appService.myInfoResponse.cBiller.id!;
    searchController.addListener(addProduct);
    scrollController.addListener(() {});
    super.onInit();
  }

  @override
  void onReady() {
    // _fetchCustomerList();
    Future.delayed(const Duration(seconds: 1)).then((value) => _getData());
    // _fetchCustomerListOff();

    super.onReady();
  }

  _getData() async {
    var myInfo = cache.getData(CacheDBPath.myInfo);
    info = MyInfoResponse.fromJSON(myInfo);
    //  List cList = cache.getData(CacheDBPath.customers);
    // List cGList = cache.getData(CacheDBPath.customersGroup);
    //  List _wList = cache.getData(CacheDBPath.warehouse);
    var _cPRes = cache.getData(CacheDBPath.customerPriceGroups);
    //List test = await sembestCatch.getAllCustomers();
    cusList.value = await sembestCatch.getAllCustomers();
    // custGrps.value = customerGroupResponseFromJson(jsonEncode(cGList));
    wLsit.value = await sembestCatch.getAllwarehouses();
    selectedCustomerName.value = cusList.first.name.toString();
    customerPriceGroup.value = CustomerPriceGroupsResponse.fromJson(_cPRes);
    cCustomerGroup.value = customerPriceGroup.value.customerGroups!.first;
    cPriceGroup.value = customerPriceGroup.value.priceGroups!.first;
    // var _prdts = cache
    //   .getData(CacheDBPath.warehouseProducts + info.warehouses!.first.id!);

    product.value = await sembestCatch.getAllProducts();
    // logger.wtf(product[0].label);
  }

  @override
  actionOnSaveRequest() {
    print("object");
    if (addFromKey.currentState!.validate()) {
      UINotification.showLoading();
      CustomerAddRequest addRequest = CustomerAddRequest();
      addRequest.name = cName.text;
      addRequest.email = email.text;
      addRequest.customerGroup = cCustomerGroup.value.id;
      addRequest.priceGroup = cPriceGroup.value.id;
      addRequest.company = company.text;
      addRequest.address = address.text;
      addRequest.vatNo = vatNo.text;
      addRequest.city = city.text;
      addRequest.state = state.text;
      addRequest.postalCode = pCode.text;
      addRequest.country = country.text;
      addRequest.phone = phone.text;
      desktopDataProvider.customerAddRequest(addRequest);
    } else {
      UINotification.showNotification(
          color: Colors.red, title: 'please_complete_form'.tr);
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  @override
  onCustomerOffListDone(List<CustomerListOffResponse>? cListRes) {
    // cusList.value = cListRes;
    cache.setData(
        CacheDBPath.customers, cListRes?.map((e) => e.toJson()).toList());
    selectedCustomerName.value = cListRes!.first.name.toString();
    UINotification.hideLoading();
  }

  @override
  onCustomerOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }

  @override
  onCustomerGrpOffListDone(List<CustomerGroupResponse> cGrpRes) {
    // custGrps.value = cGrpRes;
    // custGrp.value = cGrpRes.first.name.toString();
    UINotification.hideLoading();
  }

  @override
  onCustomerGrpOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }

  @override
  onWProductOffListDone(List<WarehouseProductsResponse> wPListRes) {
    UINotification.hideLoading();
  }

  @override
  onWProductOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }

  @override
  onWarehouseOffListDone(List<WarehouseListResponse> wListRes) {
    wLsit.value = wListRes;
    UINotification.hideLoading();
  }

  @override
  onWarehouseOffListError(ErrorMessage err) {
    UINotification.hideLoading();
  }

  @override
  onCustomerAddDone(CustomerAddResponse customerAddResponse) {
    UINotification.hideLoading();
    // UINotification.showNotification(
    // color: AppColors.greenIconColor,
    // title: customerAddResponse.message,
    // );
    // Get.back(canPop: true);
  }

  @override
  onCustomerAddError(ErrorMessage err) {
    UINotification.showNotification(color: Colors.red, title: err.message);
  }

  void calculateTotal() {
    cartTotal(0);
    for (var each in selectedProducts) {
      cartTotal.value += each.subTotal;
      totalPayable(cartTotal.value);
    }
  }

  bool checkAvailability() {
    bool _isAvailable = true;
    for (var each in selectedProducts) {
      if (each.isAvailable == true && _isAvailable == true) {
        _isAvailable = true;
      } else {
        _isAvailable = false;
      }
    }
    return _isAvailable;
  }

  // CartProduct getCartProduct(Product value) {
  //   CartProduct cartProduct = CartProduct(
  //       itemId: value.itemId,
  //       // itemName: value.row!.name,
  //       subTotal: value.row!.price,
  //       subQty: 1,
  //       quantity: value.row!.quantity,
  //       cartItem: value);
  //   return cartProduct;
  // }
  Rx<TextEditingController> paymentAmount = TextEditingController().obs;
  continuePayment() {
    UINotification.showLoading();
    SaleRequest saleRequest = SaleRequest();
    saleRequest.test = '';
    saleRequest.customer = "2";
    saleRequest.warehouse = appService.cWareHouse;
    saleRequest.addItem = '';
    saleRequest.biller = appService.cBiller;
    saleRequest.posNote = '';
    saleRequest.staffNote = '';
    for (var element in selectedProducts) {
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
      } else {
        saleRequest.productTax.add(Constants.nonTaxProduct);
      }
      // saleRequest.productTax.add('1');
      // change to net price
      saleRequest.netPrice.add(element.subTotal.toStringAsFixed(2));
      saleRequest.unitPrice.add((element.cartItem!.row!.price! -
              double.parse(element.cartItem!.row!.discount!))
          .toStringAsFixed(2));
      saleRequest.realUnitPrice
          .add(element.cartItem!.row!.realUnitPrice!.toStringAsFixed(2));
      saleRequest.quantity.add(element.subQty.toString());
      saleRequest.productUnit.add('');
      saleRequest.productBaseQuantity
          .add(element.cartItem!.row!.baseQuantity!.toString());
      //print(element.toJson());
    }
    // saleRequest.amount.add(paymentAmount.value.text);
    saleRequest.amount.add(totalPayable.toString());

    // var amountBalance = double.tryParse(changeAmount.text)!.abs() -
    //     (double.tryParse(balanceAmount.text)!);
    // var amountBalanceString = amountBalance.toStringAsFixed(2);
    saleRequest.balanceAmount.add("0");
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
    saleRequest.totalItems = selectedProducts.length.toString();
    var data = jsonEncode(saleRequest.toJson());
    print(data);
    desktopDataProvider.saleOrderRequest(saleRequest);
  }

  void actionOnPayment() {
    paymentAmount.value.text = totalPayable.toString();
  }

  @override
  onSaleDone(AddSaleResponse addSaleResponse) {
    print(addSaleResponse.toJson());
    selectedProducts.clear();
    calculateTotal();
    totalPayable(0.0);
    Get.back();
    // TODO: implement onSaleDone
    throw UnimplementedError();
  }

  @override
  onSaleError(ErrorMessage err) {
    // TODO: implement onSaleError
    throw UnimplementedError();
  }

  void clearCart() {
    if (selectedProducts.isNotEmpty) {
      Get.defaultDialog(
        middleText: "Are you sure to Cancel",
        // middleText: "Please change the quantity in cart or remove the product",
        backgroundColor: Colors.white,
        textConfirm: "Confirm",
        textCancel: "Cancel",
        onConfirm: () {
          selectedProducts.clear();
          calculateTotal();
          totalPayable(0.0);
          Get.back();
        },
        // onCancel: () {
        //   Get.back();
        // },
      );
    }
  }
}
