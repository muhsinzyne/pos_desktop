import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/helpers/string.dart';
import 'package:posdelivery/services/app_service.dart';

import '../../../../models/response/pos/customer.dart';

class SalesPointController extends GetxController {
  //TODO: Implement SalesPointController

  final count = 0.obs;
  final TextEditingController company = TextEditingController();
  final TextEditingController pCode = TextEditingController();
  final TextEditingController cName = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController vatNo = TextEditingController();
  final TextEditingController gstNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController custom1 = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final custGrp = RxString("");
  final pGrp = RxString("");
  AppService appService = Get.find<AppService>();
  final RxString _cWareHouseName = RxString('');
  final RxString _cBillerName = RxString('');
  final RxString cCustomer = RxString('');
  final RxString selectedCustomerName = RxString('');
  final RxBool scanner = RxBool(false);
  RxList<CustomerInfo> customerList = RxList([]);
  List<String> get customerListString {
    List<String> dummyList = [];
    for (var element in customerList) {
      dummyList.add("[${element.id.toString()}]  ${element.value.toString()}");
    }
    return dummyList;
  }

  final List<String> custGrps = [
    "A",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
  ];
  final List<String> pGrps = [
    "A",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
  ];

  void changeCustomer(String value) {
    cCustomer.value = StringHelper.splitFromBracket(value);
    appService.cCustomer = cCustomer.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
