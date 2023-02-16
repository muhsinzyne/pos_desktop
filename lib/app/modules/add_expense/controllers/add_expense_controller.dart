import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseController extends GetxController {
  //TODO: Implement AddExpenseController

  final count = 0.obs;

  final TextEditingController date = TextEditingController();
  final TextEditingController reference = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController attachement = TextEditingController();
  final TextEditingController note = TextEditingController();
  final category = RxString("");
  final store = RxString("");
  final List<String> cat = [
    "A",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
  ];
  final List<String> str = [
    "A",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
  ];

  void pr() {
    print(amount);
    print(attachement);
    print(category);
    print(date);
    print(reference);
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
