import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/models/delivery/requests/expense_add_request.dart';
import 'package:posdelivery/services/cache/cache_sembast_service.dart';

class AddExpenseController extends GetxController {
  //TODO: Implement AddExpenseController

  final TextEditingController reference = TextEditingController();

  String? selectedCategory;
  String? selectedStore;
  final TextEditingController amount = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController address = TextEditingController();
  RxBool isFile = false.obs;

  CacheSembastService sembastCache = Get.find<CacheSembastService>();

  ExpenseAddRequest expenseAddRequest = ExpenseAddRequest();
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  List<CategoryOption> categories = CategoryOption.allExpenses;
  List<Stores> stores = Stores.allStores;
  // final Rxn<DateTime> _selectedDate = Rxn<DateTime>();

  void presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }

      date.text = convertDateTimeDisplay(pickedDate.toString());
    });
  }

  removeAttachments() {
    // file = null;
    isFile.value = false;
  }

  void vaidate() async {
    if (selectedStore != null &&
        selectedCategory != null &&
        date.text.isNotEmpty &&
        amount.text.isNotEmpty) {
      expenseAddRequest.amount = amount.text;
      expenseAddRequest.note = note.text;
      expenseAddRequest.category_id = selectedCategory;
      expenseAddRequest.reference = reference.text;
      expenseAddRequest.date = date.text;
      await sembastCache.setAddExpenseFormData(expenseAddRequest);
      Get.defaultDialog(
        title: "Added",
        middleText: "New Expense Added",
        middleTextStyle: TextStyle(color: Colors.black),
      );
    } else {
      Get.snackbar("title", "enter all fields");
    }
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
  void onClose() {
    reference.dispose();
    amount.dispose();
    address.dispose();
    date.dispose();
    super.onClose();
  }
}

class CategoryOption {
  final String key;
  final String fullName;

  CategoryOption(this.key, this.fullName);

  static List<CategoryOption> get allExpenses => [
        CategoryOption('1', 'Transportation'),
        CategoryOption('2', 'Mortgage(s)'),
        CategoryOption('3', 'Rent'),
        CategoryOption('12', 'Vehichle maintenance'),
      ];
}

class Stores {
  final String key;
  final String fullName;

  Stores(this.key, this.fullName);

  static List<Stores> get allStores => [
        Stores('1', 'Store 1'),
        Stores('2', 'Store 2'),
        Stores('3', 'Store 3'),
        Stores('4', 'Store 4'),
      ];
}
