import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/helpers/string.dart';
import 'package:posdelivery/app/modules/sales_point/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/cache_db_path.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/requests/customer/customer_add_request.dart';
import 'package:posdelivery/models/requests/pos/cart_offlline_product.dart';
import 'package:posdelivery/models/requests/pos/cart_product.dart';
import 'package:posdelivery/models/requests/pos/invoice_offline.dart';
import 'package:posdelivery/models/requests/pos/sale_offline_request.dart';
import 'package:posdelivery/models/requests/pos/sale_request.dart';
import 'package:posdelivery/models/requests/pos/sale_view_request.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/customer/customer_group.dart';
import 'package:posdelivery/models/response/customer/customer_price_group_response.dart';
import 'package:posdelivery/models/response/customer/price_group.dart';
import 'package:posdelivery/models/response/desktop/customer_group.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/desktop/product_offline.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/add_sale_response.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/providers/data/desktop_data_provider.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/providers/local/blue_thermal_print_provider.dart';
import 'package:posdelivery/providers/local/pdf_invoice_provider.dart';
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

  BlueThermalPrinterProdvider blueThermalPrinterProdvider =
      Get.find<BlueThermalPrinterProdvider>();
  @override
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
  RxList<ProductOffline> productOffline = RxList([]);
  RxList<ProductOffline> cartedOfflineProducts = RxList([]);

  RxList<ProductOffline> productsOffline = RxList([]);
  // RxList<Product> selectedProducts = RxList([]);
  // var selectedProducts = RxList<ProductPurchaseInfo>();

  RxList<CartProduct> selectedProducts = RxList([]);
  RxList<CartOfflineProduct> selectedOfflineProducts = RxList([]);
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
    print(value.toJson());
    if (selectedProducts.any((element) => element.itemId == value.itemId)) {
      Get.defaultDialog(
        title: "Already in cart",
        middleText: "Please change the quantity in cart",
        backgroundColor: Colors.white,
        textCancel: "OK",
        titleStyle: const TextStyle(color: Colors.black),
        middleTextStyle: const TextStyle(color: Colors.black),
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
      if (value.row!.quantity! >= 2) {
        selectedProducts.add(product);
      } else {
        Get.defaultDialog(
          title: "Not enough stock",
          middleText: "Add more stocks",
          backgroundColor: Colors.white,
          textCancel: "OK",
          titleStyle: const TextStyle(color: Colors.black),
          middleTextStyle: const TextStyle(color: Colors.black),
        );
      }
      calculateTotal();
    }
    checkQuantity(value);
    searchController.text = "";
    // _selectedProduct.value = value;
    // logger.wtf(_selectedProduct.value.label);
  }

  addProductOnClickOffline(ProductOffline value) {
    if (selectedOfflineProducts
        .any((element) => element.itemId == value.code)) {
      Get.defaultDialog(
        title: "Already in cart",
        middleText: "Please change the quantity in cart",
        backgroundColor: Colors.white,
        textCancel: "OK",
        titleStyle: const TextStyle(color: Colors.black),
        middleTextStyle: const TextStyle(color: Colors.black),
      );
      //   int index = selectedProducts
      //       .indexWhere((element) => element.itemId == value.itemId);
      //   value.row!.qty! + 1;
      //   Product temp = value;
      //   selectedProducts.removeAt(index);
      //   selectedProducts.insert(index, temp);
    } else {
      CartOfflineProduct tempProduct = CartOfflineProduct();
      cartedOfflineProducts.add(value);
      // cartTotal.value += double.parje(value.row!.price!.toString());
      tempProduct.itemId = value.code;
      logger.wtf(value.code);
      tempProduct.subTotal = double.parse(value.price!.toString());
      tempProduct.subQty = 1;
      tempProduct.isAvailable = true;
      tempProduct.quantity = value.quantity;
      tempProduct.cartItem = value;
      if (tempProduct.quantity! >= 1) {
        logger.e("added");
        selectedOfflineProducts.add(tempProduct);
        checkQuantityOffline(value);
        calculateTotalOffline();
      } else {
        Get.defaultDialog(
          title: "Not enough stock",
          middleText: "Add more stocks",
          backgroundColor: Colors.white,
          textCancel: "OK",
          titleStyle: const TextStyle(color: Colors.black),
          middleTextStyle: const TextStyle(color: Colors.black),
        );
      }

      searchController.text = "";
    }
    // _selectedProduct.value = value;
    // logger.wtf(_selectedProduct.value.label);
  }

  removeProductOffline(CartOfflineProduct product) {
    selectedOfflineProducts.remove(product);
    cartedOfflineProducts.remove(product.cartItem);
    bool status =
        selectedOfflineProducts.every((item) => item.quantity != 0); // false
    if (status) {
      paymentFlag.value = true;
    }
    calculateTotalOffline();
  }

  removeProduct(CartProduct product) {
    selectedProducts.remove(product);
    bool status = selectedProducts.every((item) => item.quantity != 0); // false
    if (status) {
      paymentFlag.value = true;
    }
    calculateTotal();
  }

  addProductOffline() {
    //logger.e(searchController)
    ProductOffline? value = productOffline
        .firstWhereOrNull((element) => element.code == searchController.text);
    if (value != null) {
      // cartTotal.value += double.parse(value.row!.price!.toString());
      var product = CartOfflineProduct();
      cartedOfflineProducts.add(value);
      product.itemId = value.code;
      product.subTotal = double.parse(value.price!.toString());
      product.subQty = 1;
      product.isAvailable = true;
      product.quantity = value.quantity;
      product.cartItem = value;
      if (product.quantity! >= 1) {
        selectedOfflineProducts.add(product);
      } else {
        Get.defaultDialog(
          title: "Not enough stock",
          middleText: "Add more stocks",
          backgroundColor: Colors.white,
          textCancel: "OK",
          titleStyle: const TextStyle(color: Colors.black),
          middleTextStyle: const TextStyle(color: Colors.black),
        );
      }
      checkQuantityOffline(value);
      calculateTotalOffline();
      searchController.text = "";
    } else {}
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
      if (product.quantity! >= 1) {
        selectedProducts.add(product);
      } else {
        Get.defaultDialog(
          title: "Not enough stock",
          middleText: "Add more stocks",
          backgroundColor: Colors.white,
          textCancel: "OK",
          titleStyle: const TextStyle(color: Colors.black),
          middleTextStyle: const TextStyle(color: Colors.black),
        );
      }
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

  checkQuantityOffline(ProductOffline product) {
    if (product.quantity == 0) {
      Get.defaultDialog(
        title: "Out of stock",
        middleText: "Add more stocks",
        backgroundColor: Colors.white,
        textCancel: "OK",
        titleStyle: const TextStyle(color: Colors.black),
        middleTextStyle: const TextStyle(color: Colors.black),
      );
      removeProduct(selectedProducts
          .firstWhere((cartItem) => cartItem.cartItem!.id == product.code));

      paymentFlag.value = checkAvailability();
    }
  }

  checkQuantity(Product product) {
    if (product.row!.quantity == 0) {
      Get.defaultDialog(
        title: "Out of stock",
        middleText: "Add more stocks",
        backgroundColor: Colors.white,
        textCancel: "OK",
        titleStyle: const TextStyle(color: Colors.black),
        middleTextStyle: const TextStyle(color: Colors.black),
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
  checkAvailableQuantityOffline(int index, String? value) {
    if (value!.isNotEmpty) {
      if (int.parse(value) >
          selectedOfflineProducts[index].cartItem!.quantity!) {
        paymentFlag.value = false;
        selectedOfflineProducts[index].isAvailable = false;
        Get.defaultDialog(
          title: "Not enough stock",
          middleText: "Add more stocks",
          backgroundColor: Colors.white,
          textCancel: "OK",
          titleStyle: const TextStyle(color: Colors.black),
          middleTextStyle: const TextStyle(color: Colors.black),
        );
      } else {
        int _qty = int.parse(value);
        selectedOfflineProducts[index].subQty = _qty;
        selectedOfflineProducts[index].isAvailable = true;
        selectedOfflineProducts[index].subTotal =
            selectedOfflineProducts[index].cartItem!.price!.toDouble() * _qty;
        calculateTotalOffline();
        paymentFlag.value = checkAvailabilityOffline();
      }
    } else {
      Get.defaultDialog(
        title: "Quantity cannot be zero",
        middleText: "Please change the quantity in cart or remove the product",
        backgroundColor: Colors.white,
        textCancel: "OK",
        titleStyle: const TextStyle(color: Colors.black),
        middleTextStyle: const TextStyle(color: Colors.black),
      );
      calculateTotalOffline();
      // removeProduct(selectedProducts[index]);
    }
  }

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
          titleStyle: const TextStyle(color: Colors.black),
          middleTextStyle: const TextStyle(color: Colors.black),
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
        titleStyle: const TextStyle(color: Colors.black),
        middleTextStyle: const TextStyle(color: Colors.black),
      );
      calculateTotal();
      // removeProduct(selectedProducts[index]);
    }
  }

  @override
  void onInit() async {
    final isOnline = await hasNetwork();
    if (isOnline) {
      final _sales = await sembestCatch.getAddSaleData();
      if (_sales.isNotEmpty) {
        for (var _sale in _sales) {
          log(_sale.toJson().toString());
          // desktopDataProvider.saleOrderRequest(_sale);
        }
      }
    }
    // posDataProvider.salePointCallBack = this;
    desktopDataProvider.salePointCallBack = this;
    _cWareHouseName.value = appService.myInfoResponse.cWareHouse.name ?? '';
    _cBillerName.value = appService.myInfoResponse.cBiller.name ?? '';
    appService.cWareHouse = appService.myInfoResponse.cWareHouse.id!;
    appService.cBiller = appService.myInfoResponse.cBiller.id!;
    searchController.addListener(addProductOffline);
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
    productsOffline.value = await sembestCatch.getAllProductsOffline();
    // selectedOfflineProducts.a
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

  void calculateTotalOffline() {
    cartTotal(0);

    for (CartOfflineProduct each in selectedOfflineProducts) {
      // logger.w(each.subTotal);
      cartTotal.value += each.subTotal;
    }
    totalPayable(cartTotal.value);
  }

  void calculateTotal() {
    cartTotal(0);
    for (var each in selectedProducts) {
      cartTotal.value += each.subTotal;
      totalPayable.value = cartTotal.value;
    }
  }

  bool checkAvailabilityOffline() {
    bool _isAvailable = true;
    for (var each in selectedOfflineProducts) {
      if (each.isAvailable == true && _isAvailable == true) {
        _isAvailable = true;
      } else {
        _isAvailable = false;
      }
    }
    return _isAvailable;
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

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
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
  continuePaymentOffline() async {
    UINotification.showLoading();
    SaleOfflineRequest saleOfflineRequest = SaleOfflineRequest();
    saleOfflineRequest.customer = "2";
    saleOfflineRequest.warehouse = appService.cWareHouse;
    saleOfflineRequest.biller = appService.cBiller;
    saleOfflineRequest.posNote = '';
    saleOfflineRequest.staffNote = '';
    for (var element in selectedOfflineProducts) {
      saleOfflineRequest.productCode.add(element.cartItem!.code!);
      saleOfflineRequest.productName.add(element.cartItem!.name!);
      saleOfflineRequest.productOption.add('false');
      saleOfflineRequest.productComment.add('');
      // saleRequest.serial.add('');
      // saleRequest.productDiscount.add('0');
      if (element.cartItem!.tax != null) {
        saleOfflineRequest.productTax.add(Constants.isTaxProduct);
      } else {
        saleOfflineRequest.productTax.add(Constants.nonTaxProduct);
      }
      // saleRequest.productTax.add('1');
      // change to net price
      saleOfflineRequest.netPrice.add(element.subTotal.toStringAsFixed(2));
      saleOfflineRequest.unitPrice
          .add((element.cartItem!.price!).toStringAsFixed(2));
      // saleRequest.realUnitPrice .add(element.cartItem!.!.realUnitPrice!.toStringAsFixed(2));
      saleOfflineRequest.quantity.add(element.subQty.toString());
      saleOfflineRequest.productUnit.add('');
      // saleRequest.productBaseQuantity
      // .add(element.cartItem!.row!.baseQuantity!.toString());
      //print(element.toJson());
    }
    // saleRequest.amount.add(paymentAmount.value.text);
    saleOfflineRequest.amount.add(totalPayable.toString());

    // var amountBalance = double.tryParse(changeAmount.text)!.abs() -
    //     (double.tryParse(balanceAmount.text)!);
    // var amountBalanceString = amountBalance.toStringAsFixed(2);
    saleOfflineRequest.balanceAmount.add("0");
    saleOfflineRequest.paidBy.add('cash');
    saleOfflineRequest.ccNo.add('');
    saleOfflineRequest.payingGiftCardNo.add('');
    saleOfflineRequest.ccHolder.add('');
    saleOfflineRequest.chequeNo.add('');
    saleOfflineRequest.ccMonth.add('');
    saleOfflineRequest.ccYear.add('');
    saleOfflineRequest.ccType.add('');
    saleOfflineRequest.ccCvv2.add('');
    saleOfflineRequest.paymentNote.add('');
    saleOfflineRequest.orderTax = '0';
    saleOfflineRequest.discount = '0';
    saleOfflineRequest.shipping = '0';
    saleOfflineRequest.rPaidBy = 'cash';
    saleOfflineRequest.totalItems = selectedProducts.length.toString();
    cacheSale(saleOfflineRequest);
  }

  continuePayment() async {
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
    final isOnline = await hasNetwork();
    if (isOnline) {
      print(isOnline);
      desktopDataProvider.saleOrderRequest(saleRequest);
    } else {
      print(isOnline);
      // cacheSale();
    }
  }

  cacheSale(SaleOfflineRequest saleOfflineRequest) async {
    sembestCatch.setAddSaleData(saleOfflineRequest);
    generateInvoice(saleOfflineRequest);
    Get.back();
    UINotification.hideLoading();
    SmartDialog.showToast("Sales Added to cache");
  }

  generateInvoice(SaleOfflineRequest saleOfflineRequest) async {
    InvoiceOfflineResponse invoiceOfflineResponse = InvoiceOfflineResponse();
    invoiceOfflineResponse.saleNo = "";
    invoiceOfflineResponse.saleRef = "";
    invoiceOfflineResponse.totalItem =
        int.tryParse(saleOfflineRequest.totalItems!);
    invoiceOfflineResponse.date = "";
    invoiceOfflineResponse.totalQty = 10;
    invoiceOfflineResponse.subTotal = 10;
    invoiceOfflineResponse.discount = "";
    invoiceOfflineResponse.totalTax = 0;
    invoiceOfflineResponse.grandTotal = 1030;
    invoiceOfflineResponse.rows.addAll(cartedOfflineProducts);
    blueThermalPrinterProdvider.loadImage(invoiceOfflineResponse.logoPath);
    await Future.delayed(Duration(seconds: 2));
    blueThermalPrinterProdvider.printReceiveTestOffline(invoiceOfflineResponse);
  }

  void actionOnPayment() {
    paymentAmount.value.text = totalPayable.toString();
  }

  @override
  onSaleDone(AddSaleResponse addSaleResponse) {
    Get.back();
    getInvoice(addSaleResponse.data!.saleId!);
    selectedProducts.clear();
    calculateTotal();
    totalPayable(0.0);
  }

  @override
  onSaleError(ErrorMessage err) {
    print(err.message);
    // throw UnimplementedError();
  }

  void clearCartOffline() {
    if (selectedOfflineProducts.isNotEmpty) {
      Get.defaultDialog(
        middleText: "Are you sure to Cancel",
        // middleText: "Please change the quantity in cart or remove the product",
        backgroundColor: Colors.white,
        textConfirm: "Confirm",
        textCancel: "Cancel",
        onConfirm: () {
          selectedOfflineProducts.clear();
          calculateTotalOffline();
          totalPayable(0.0);
          Get.back();
        },
        // onCancel: () {
        //   Get.back();
        // },
      );
    }
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

  getInvoice(num saleId) {
    print("Reached getInvoice");
    SaleViewRequest saleViewRequest = SaleViewRequest();
    saleViewRequest.saleId = saleId.toString();
    desktopDataProvider.getSaleInvoice(saleViewRequest);
  }

  @override
  onSaleViewError(ErrorMessage err) {
    print(err.message);
    throw UnimplementedError();
  }

  Rx<InvoiceResponse> invoiceResponse = InvoiceResponse().obs;
  @override
  onSaleViewFetchDone(InvoiceResponse res) {
    invoiceResponse(res);
    print(invoiceResponse.value.toJson());
    printInvoice();
    UINotification.hideLoading();
    // throw UnimplementedError();
  }

  printInvoice() async {
    await Future.delayed(Constants.smallDuration);
    final pffFile = await PdfInvoiceProvider.generate(invoiceResponse.value);
    PdfInvoiceProvider.openFile(pffFile);
  }

  connectPrinter() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    await scan();
    if (selectedPrinter != null) {
      connectDevice();
    }
    _printEscPos(await testTicket(), generator);
  }

  Future<List<int>> testTicket() async {
    // final List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));
    // bytes += generator.text('Special 2: blåbærgrød',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes +=
        generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);
    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }

  var defaultPrinterType = PrinterType.usb;
  final _isBle = false;
  final _reconnect = false;
  bool _isConnected = false;
  var printerManager = PrinterManager.instance;
  var devices = <BluetoothPrinter>[];
  StreamSubscription<PrinterDevice>? _subscription;
  StreamSubscription<BTStatus>? _subscriptionBtStatus;
  StreamSubscription<USBStatus>? _subscriptionUsbStatus;
  final BTStatus _currentStatus = BTStatus.none;
  // _currentUsbStatus is only supports on Android
  final USBStatus _currentUsbStatus = USBStatus.none;
  List<int>? pendingTask;
  final String _ipAddress = '';
  final String _port = '9100';
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  BluetoothPrinter? selectedPrinter;
  scan() {
    devices.clear();
    _subscription = printerManager
        .discovery(type: defaultPrinterType, isBle: _isBle)
        .listen((device) {
      devices.add(BluetoothPrinter(
        deviceName: device.name,
        address: device.address,
        isBle: _isBle,
        vendorId: device.vendorId,
        productId: device.productId,
        typePrinter: defaultPrinterType,
      ));
      selectDevice(devices.first);
    });
  }

  selectDevice(BluetoothPrinter device) async {
    if (selectedPrinter != null) {
      if ((device.address != selectedPrinter!.address) ||
          (device.typePrinter == PrinterType.usb &&
              selectedPrinter!.vendorId != device.vendorId)) {
        await PrinterManager.instance
            .disconnect(type: selectedPrinter!.typePrinter);
      }
    }

    selectedPrinter = device;
    return device;
  }

  void _printEscPos(List<int> bytes, Generator generator) async {
    if (selectedPrinter == null) return;
    var bluetoothPrinter = selectedPrinter!;

    switch (bluetoothPrinter.typePrinter) {
      case PrinterType.usb:
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: UsbPrinterInput(
                name: bluetoothPrinter.deviceName,
                productId: bluetoothPrinter.productId,
                vendorId: bluetoothPrinter.vendorId));
        pendingTask = null;
        if (Platform.isAndroid) pendingTask = bytes;
        break;
      case PrinterType.bluetooth:
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: BluetoothPrinterInput(
                name: bluetoothPrinter.deviceName,
                address: bluetoothPrinter.address!,
                isBle: bluetoothPrinter.isBle ?? false,
                autoConnect: _reconnect));
        pendingTask = null;
        if (Platform.isIOS || Platform.isAndroid) pendingTask = bytes;
        break;
      case PrinterType.network:
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter.typePrinter,
            model: TcpPrinterInput(ipAddress: bluetoothPrinter.address!));
        break;
      default:
    }
    if (bluetoothPrinter.typePrinter == PrinterType.bluetooth) {
      if (_currentStatus == BTStatus.connected) {
        printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
        pendingTask = null;
      }
    } else if (bluetoothPrinter.typePrinter == PrinterType.usb &&
        Platform.isAndroid) {
      // _currentUsbStatus is only supports on Android
      if (_currentUsbStatus == USBStatus.connected) {
        printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
        pendingTask = null;
      }
    } else {
      printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
    }
  }

  connectDevice() async {
    _isConnected = false;
    if (selectedPrinter == null) return;
    switch (selectedPrinter!.typePrinter) {
      case PrinterType.usb:
        await printerManager.connect(
            type: selectedPrinter!.typePrinter,
            model: UsbPrinterInput(
                name: selectedPrinter!.deviceName,
                productId: selectedPrinter!.productId,
                vendorId: selectedPrinter!.vendorId));
        _isConnected = true;
        break;
      case PrinterType.bluetooth:
        await printerManager.connect(
            type: selectedPrinter!.typePrinter,
            model: BluetoothPrinterInput(
                name: selectedPrinter!.deviceName,
                address: selectedPrinter!.address!,
                isBle: selectedPrinter!.isBle ?? false,
                autoConnect: _reconnect));
        break;
      case PrinterType.network:
        await printerManager.connect(
            type: selectedPrinter!.typePrinter,
            model: TcpPrinterInput(ipAddress: selectedPrinter!.address!));
        _isConnected = true;
        break;
      default:
    }
  }
}

class BluetoothPrinter {
  int? id;
  String? deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  bool? isBle;

  PrinterType typePrinter;
  bool? state;

  BluetoothPrinter(
      {this.deviceName,
      this.address,
      this.port,
      this.state,
      this.vendorId,
      this.productId,
      this.typePrinter = PrinterType.bluetooth,
      this.isBle = false});
}
