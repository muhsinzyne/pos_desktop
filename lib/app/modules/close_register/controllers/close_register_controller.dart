import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CloseRegisterController extends GetxController {
  //TODO: Implement CloseRegisterController

  final count = 0.obs;
  final TextEditingController totalCash = TextEditingController();
  final TextEditingController totalCards = TextEditingController();
  final TextEditingController totalCheques = TextEditingController();
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
