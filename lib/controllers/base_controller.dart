import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posdelivery/app/config/flavor/flavor_service.dart';
import 'package:posdelivery/app/modules/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/app_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/currency_format.dart';
import 'package:posdelivery/models/response/auth/employee_info.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/models/url.dart';
import 'package:posdelivery/providers/data/auth_data_provider.dart';
import 'package:posdelivery/services/app_service.dart';
import 'package:posdelivery/services/storage/local_storage_service.dart';

import '../models/response/pos/sales_list.dart';

class BaseGetXController extends GetxController implements IBaseGetXController {
  // base dependency injections
  LocalStorage localStorage = Get.find<LocalStorage>();
  AppController appController = Get.find<AppController>();
  AppService appService = Get.find<AppService>();
  AuthDataProvider authDataProvider = Get.find<AuthDataProvider>();
  CurrencyFormat sr = CurrencyConst.srFormat1;

  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    authDataProvider.callBack = this;
    super.onInit();
  }

  @override
  onLoadTokenInvalid() async {
    appService.authToken = Constants.none;
    if (appService.isLastLoggedIn) {
      Get.snackbar(
        'error'.tr,
        'login_no_login_credentials_please_login'.tr,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      appService.isLastLoggedIn = false;
    }
    await Future.delayed(Constants.smallDuration);
    Get.offAllNamed(Routes.login);
  }

  @override
  void onLoadTokenValid(EmployeeInfo employeeInfo) {
    appService.employeeInfo = employeeInfo;
    print("on token validated");
    Get.offAllNamed(Routes.dashboard);
  }

  @override
  void validateLogin() async {
    if (localStorage.isAuthToken) {
      validateToken();
    } else {
      onLoadTokenInvalid();
    }
  }

  @override
  void validateToken() {
    authDataProvider.getProfileInfo();
  }

  @override
  void onTokenValid(MyInfoResponse myInfoResponse) async {
    appService.myInfoResponse = myInfoResponse;
    await Future.delayed(Constants.smallDuration);
    // Get.offNamed(Routes.dashboard);
    Get.offNamed(Routes.deliverySales);
  }

  @override
  void validateLicence() async {
    // appService.appServer = Constants.none;
    // appService.authToken = Constants.none;
    if (localStorage.isAppServer) {
      onValidLicence();
    } else {
      onInvalidLicence();
    }
  }

  @override
  void onInvalidLicence() async {
    appService.appServer = Constants.none;
    if (appService.isLastLoggedIn) {
      Get.snackbar(
        'error'.tr,
        'your_licence_got_invalid_please_activate_your_licence'.tr,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      appService.isLastLoggedIn = false;
    }
    await Future.delayed(Constants.smallDuration);
    Get.offAllNamed(Routes.licence);
  }

  @override
  void onValidLicence() async {
    String apiUrl = localStorage.getString(Constants.appServer)!;
    String appPrefix = localStorage.getString(Constants.appPrefix)!;
    FlavorConfig.instance.flavorValues.api = apiUrl.toString();
    FlavorConfig.instance.flavorValues.appPrefix = appPrefix.toString();
    print("\n \n \n ");
    print(appPrefix);
    validateLogin();
  }

  nextFocus(FocusNode focusNode, context) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void openInvoice(InvoiceResponse invoiceResponse) async {
    UINotification.showLoading();
    var apiUrl = NetworkURL.api +
        Constants.invoicePdfPrefix +
        invoiceResponse.inv!.id! +
        Constants.pdf;
    File? file = await downloadFile(apiUrl);
    if (file == null) {
      return;
    }
    print('path: ${file.path}');
    OpenFile.open(file.path);
    UINotification.hideLoading();
  }

  void openFile(SalesInfoShort salesInfoShort) async {
    UINotification.showLoading();
    var apiUrl = NetworkURL.api +
        Constants.invoicePdfPrefix +
        salesInfoShort.id! +
        Constants.pdf;
    File? file = await downloadFile(apiUrl);
    if (file == null) {
      return;
    }
    print('path: ${file.path}');
    OpenFile.open(file.path);
    UINotification.hideLoading();
  }

  Future<File?> downloadFile(String url) async {
    try {
      final name = url.split('/').last;
      String dir = (await getApplicationDocumentsDirectory()).path;
      print(dir);
      File file = File('$dir/$name');
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
