import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/helpers/string.dart';
import 'package:posdelivery/app/modules/pos/contract.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/billers.dart';
import 'package:posdelivery/models/response/pos/customer.dart';
import 'package:posdelivery/models/response/pos/customer_list_response.dart';
import 'package:posdelivery/models/response/pos/warehouse.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class FindCustomerScreenController extends BaseGetXController
    implements IFindCustomerScreenController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();

  final RxString _cWareHouseName = RxString('');
  final RxString _cBillerName = RxString('');
  final RxString cCustomer = RxString('');
  final RxString selectedCustomerName = RxString('');
  final RxBool scanner = RxBool(false);
  RxList<CustomerInfo> customerList = RxList([]);

  // FindCustomerScreenController(this.qrController, this.result);
  String get cWareHouseName => _cWareHouseName.value;
  String get cBillerName => _cBillerName.value;
  List<String> get customerListString {
    List<String> dummyList = [];
    for (var element in customerList) {
      dummyList.add("[${element.id.toString()}]  ${element.value.toString()}");
    }
    return dummyList;
  }
  //QRViewController qrController;
  //Barcode result;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void onInit() {
    posDataProvider.findCustomerCallBack = this;
    _cWareHouseName.value = appService.myInfoResponse.cWareHouse.name ?? '';
    _cBillerName.value = appService.myInfoResponse.cBiller.name ?? '';
    appService.cWareHouse = appService.myInfoResponse.cWareHouse.id!;
    appService.cBiller = appService.myInfoResponse.cBiller.id!;
    super.onInit();
  }

  @override
  void onReady() {
    _fetchCustomerList();
    super.onReady();
  }

  _fetchCustomerList() {
    UINotification.showLoading();
    posDataProvider.getAllCustomerList();
  }

  // void onQRViewCreated(QRViewController qrCont) {
  //   qrController = qrCont;
  //   qrController.scannedDataStream.listen((scanData) {
  //     print("got qr data");
  //     result = scanData;
  //   });
  // }

  void actionOnCustomerAdd() {
    Get.toNamed(Routes.customerAdd)?.then((value) {
      _fetchCustomerList();
    });
  }

  void changeCustomer(String value) {
    cCustomer.value = StringHelper.splitFromBracket(value);
    appService.cCustomer = cCustomer.value;
  }

  void actionToPosPage() {
    if (cCustomer.value != '' && cBillerName != '' && cWareHouseName != '') {
      Get.toNamed(Routes.posBill);
    } else {
      Get.snackbar(
        'error'.tr,
        'please_select_sale_informations'.tr,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void onScannedResult(String value) {
    if (value != null) {
      final CustomerInfo tempCInfo =
          customerList.firstWhere((element) => element.id == value);
      cCustomer.value = tempCInfo.id!;
      selectedCustomerName.value =
          "[${tempCInfo.id.toString()}]  ${tempCInfo.value.toString()}";
    }
  }

  void changeBiller(String value) {
    final Billers searchB = appService.myInfoResponse.billers!
        .firstWhere((element) => element.id == value);
    appService.cBiller = searchB.id!;
    if (searchB != null) {
      appService.myInfoResponse.billerId = searchB.id;
      _cBillerName.value = searchB.name ?? '';
    }
  }

  void changeWarehouse(String value) {
    final Warehouses searchW = appService.myInfoResponse.warehouses!
        .firstWhere((element) => element.id == value);
    appService.cWareHouse = searchW.id!;
    if (searchW != null) {
      appService.myInfoResponse.warehouseId = searchW.id;
      _cWareHouseName.value = searchW.name ?? '';
    }
  }

  @override
  onCustomerListDone(CustomerListResponse cListResponse) {
    customerList.value = cListResponse.customers!;
    UINotification.hideLoading();
  }

  @override
  onCustomerListError(ErrorMessage err) {
    UINotification.hideLoading();
  }
}
