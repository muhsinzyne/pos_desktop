import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:posdelivery/app/config/flavor/flavor_service.dart';
import 'package:posdelivery/models/app_languages.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/requests/pos/product_purchase_info.dart';
import 'package:posdelivery/models/response/auth/employee_info.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/services/base/get_x_service.dart';
import 'package:posdelivery/services/storage/local_storage_service.dart';

class AppService extends BaseGetXService {
  final RxString _cCustomer = RxString('');
  final RxString _cBiller = RxString('');
  final RxString _cWareHouse = RxString('');
  PackageInfo? packageInfo;
  EmployeeInfo? employeeInfo;
  MyInfoResponse myInfoResponse = MyInfoResponse();
  LocalStorage localStorage = Get.find<LocalStorage>();
  RxList<ProductPurchaseInfo> productPurchaseList = RxList([]);
  final RxDouble _grandTotal = RxDouble(0);

  // ///for bluetooth printer
  // BluetoothDevice device;
  // BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  final _authToken = RxString('');
  final _isLastLoggedIn = RxBool(false);
  final _appServer = RxString('');
  final _appPrefix = RxString('');
  final _qrCodeResult = RxString('');
  final isScanned = RxBool(false);

  // ///for bluetooth printer
  // final RxBool _printerConn = RxBool(false);
  // final RxString printerConMsg = RxString('no_connected_devise'.tr);

  final List<AppLocale> languageList = AppLocale.appLocalList;

  @override
  void onInit() {
    dependencies();
    super.onInit();
    //ever(_authToken, (_) => print(_authToken.value));
    ever(_appServer, (_) => print(_appServer.value));
    ever(productPurchaseList, (_) => _calculateOrderTotal());
    //ever(_isLastLoggedIn, (_) => print("is logged in updated -  ${_isLastLoggedIn.value}"));
    // ever(_printerConn, (_) {
    //   print("printer connection changed RxBool");
    //   print(_printerConn.value);
    // });
  }

  @override
  Future dependencies() async {
    try {
      packageInfo = await PackageInfo.fromPlatform();
    } on Exception {
      //
    }

    _preloadValues();
  }

  // bool get printerConn => _printerConn.value;
  String get grandTotalAmount {
    return _grandTotal.value.toStringAsFixed(2);
  }

  String get cCustomer => _cCustomer.value;
  String get cBiller => _cBiller.value;
  String get cWareHouse => _cWareHouse.value;
  String get authToken => _authToken.value;
  bool get isLastLoggedIn => _isLastLoggedIn.value;
  String get qrCodeResult => _qrCodeResult.value;
  String get cdnUrl =>
      FlavorConfig.instance.flavorValues.api + Constants.smaUploadPath + '/';
  String get saasCdnUrl =>
      FlavorConfig.instance.flavorValues.api +
      Constants.smaUploadPath +
      '/' +
      FlavorConfig.instance.flavorValues.appPrefix +
      '/';

  // /// for bluetooth printer
  // set printerConn(bool value) {
  //   _printerConn.value = value;
  // }

  set grandTotal(double value) {
    _grandTotal.value = value;
  }

  set qrCodeResult(String value) {
    _qrCodeResult.value = value;
    isScanned.value = true;
  }

  set isLastLoggedIn(bool value) {
    _isLastLoggedIn.value = value;
    localStorage.setBool(Constants.isLastLoggedIn, value);
  }

  set authToken(String value) {
    _authToken.value = value;
    localStorage.setString(Constants.authToken, value);
  }

  set appServer(String value) {
    _appServer.value = value;
    localStorage.setString(Constants.appServer, value);
  }

  set cCustomer(String value) {
    _cCustomer.value = value;
    localStorage.setString(Constants.cCustomer, value);
  }

  set cBiller(String value) {
    _cBiller.value = value;
    localStorage.setString(Constants.cBiller, value);
  }

  set cWareHouse(String value) {
    _cWareHouse.value = value;
    localStorage.setString(Constants.cWareHouse, value);
  }

  set appPrefix(String value) {
    _appPrefix.value = value;
    localStorage.setString(Constants.appPrefix, value);
  }

  // /// for bluetooth printer
  // void initBluetoothScan() async {
  //   bluetoothPrint.startScan(timeout: Constants.fourSec);
  //   printerConn = await bluetoothPrint.isConnected;
  //   bluetoothPrint.state.listen((state) {
  //     switch (state) {
  //       case BluetoothPrint.CONNECTED:
  //         printerConn = true;
  //         printerConMsg.value = 'connection_success'.tr;
  //         break;
  //       case BluetoothPrint.DISCONNECTED:
  //         printerConn = false;
  //         printerConMsg.value = 'disconnected_from_printer'.tr;
  //         break;
  //       default:
  //         break;
  //     }
  //     print("bluetooth scan result updated");
  //   });
  // }
  //
  // void stopBluetoothScan() async {
  //   //bluetoothPrint.stopScan();
  //}

  _preloadValues() {
    // final String tempToken = localStorage.getString(Constants.authToken)!;
    // dont know how to configure flavor so manually assigning auth token.. not safe!
    // and its's not working in mobile build only in desktop buils
    // will adapt to flavor after learning
    final String tempToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjciLCJ1c2VybmFtZSI6ImRlbW8iLCJlbWFpbCI6Im5hc2FydWRlZW4zNjdAZ21haWwuY29tIiwidmlld19yaWdodCI6IjAiLCJncm91cF9pZCI6IjEiLCJ3YXJlaG91c2VfaWQiOm51bGwsInRpbWUiOjE2NTk4NDgyMjZ9.VOsaYqCzu75MBzjRFnc39py09_7-mz-medjplC4k9XA";
    final String tempAppServer = localStorage.getString(Constants.appServer)!;
    final String tempAppPrefix = localStorage.getString(Constants.appPrefix)!;
    authToken = tempToken.toString();
    appServer = tempAppServer.toString();
    appPrefix = tempAppPrefix.toString();
  }

  _calculateOrderTotal() {
    print("ever triggered");
    _grandTotal.value = 0;
    for (var element in productPurchaseList) {
      _grandTotal.value += element.totalAmount;
    }
  }
}
