import 'dart:convert';
import 'package:posdelivery/models/delivery/requests/expense_add_request.dart';
import 'package:posdelivery/providers/data/base_data_provider.dart';
import 'dart:io';

import 'package:dio/dio.dart' as form;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/status_codes.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/base/network.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/location_service.dart';
import 'dart:async';

class DeliveryAddExpensesScreenController extends BaseGetXController {
  final TextEditingController reference = TextEditingController();
  String? category;
  final TextEditingController amount = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController address = TextEditingController();
  form.MultipartFile? file;
  RxBool isFile = false.obs;

  late bool isOnline;
  late DioNetwork network = DioNetwork();
  List<ExpenseAddRequest> formData = [];
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  StoreAddRequest storeAddRequest = StoreAddRequest();
  CacheSembastDeliveryService sembastCache =
      Get.find<CacheSembastDeliveryService>();

  ExpenseAddRequest expenseAddRequest = ExpenseAddRequest();

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
  List<CategoryOption> categories = CategoryOption.allCountries;

  addAttachments() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    // FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      file =
          form.MultipartFile.fromFileSync(result.files.single.path.toString());
      isFile.value = true;
      result.files.clear();
      // files = result.paths .map((path) => form.MultipartFile.fromFileSync(path.toString())) .toList();
    } else {
      // User canceled the picker
    }
  }

  removeAttachments() {
    file = null;
    isFile.value = false;
  }

  void cacheOrInsert() async {
    if (isOnline) {
      var formData = form.FormData.fromMap({
        'amount': amount.text,
        'note': note.text,
        'category_id': category,
        'reference': reference.text,
        'attachment': file,
      });
      deliveryDataProvider.expenseAddRequest(formData);
      Get.snackbar("Saved", "Saved Succesfully");
    } else {
      expenseAddRequest.amount = amount.text;
      expenseAddRequest.note = note.text;
      expenseAddRequest.category_id = category;
      expenseAddRequest.reference = reference.text;
      await sembastCache.setAddExpenseFormData(expenseAddRequest);
      Get.snackbar("internet",
          "No internet data will be added when internet is available");
    }
  }

  // initialization for chrcking internet and cached data
  void init() async {
    isOnline = await hasNetwork();
    if (isOnline) {
      formData = await sembastCache.getAddExpenseFormData();
      logger.w(formData.length);
      if (formData.isNotEmpty) {
        var i;
        for (i = 0; i < formData.length; i++) {
          deliveryDataProvider.expenseAddRequestWithoutFile(formData[i]);
        }
        //delete cache after sending request
        await sembastCache.deleteAddExpenseFormData();
        Get.snackbar("Cached", "Cached $i requests is Saved Succesfully");
      }
    }
  }

  void vaidate() async {
    if (reference.text.isNotEmpty &&
        category!.isNotEmpty &&
        amount.text.isNotEmpty &&
        note.text.isNotEmpty) {
      cacheOrInsert();
    } else {
      Get.snackbar("title", "enter all fields");
    }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    reference.dispose();
    amount.dispose();
    address.dispose();
    super.onClose();
  }
}

class CategoryOption {
  final String key;
  final String fullName;

  CategoryOption(this.key, this.fullName);

  static List<CategoryOption> get allCountries => [
        CategoryOption('1', 'Transportation'),
        CategoryOption('2', 'Mortgage(s)'),
        CategoryOption('3', 'Rent'),
        CategoryOption('12', 'Vehichle maintenance'),
      ];
}
