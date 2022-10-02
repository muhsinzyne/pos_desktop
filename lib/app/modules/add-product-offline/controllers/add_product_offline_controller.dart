import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/models/response/desktop/product_offline.dart';
import 'package:posdelivery/services/cache/cache_sembast_service.dart';
import 'package:excel_to_json/ExcelToJson.dart';
import 'package:posdelivery/services/location_service.dart';

class AddProductOfflineController extends GetxController {
  //TODO: Implement AddExpenseController

  final count = 0.obs;

  final TextEditingController date = TextEditingController();
  final TextEditingController productCode = TextEditingController();
  final TextEditingController productName = TextEditingController();
  final TextEditingController productQuantity = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController productCost = TextEditingController();
  final TextEditingController reference = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController attachement = TextEditingController();
  final TextEditingController note = TextEditingController();
  String? selectedCategory;
  String? selectedUnit;
  String? selectedTax;
  List<ProductCategoryOption> productCategories =
      ProductCategoryOption.allCategories;
  List<ProductUnitOption> productUnitsCategory = ProductUnitOption.allUnits;
  List<ProductTaxOption> productTaxCategory = ProductTaxOption.allTax;
  ProductOffline offlineProduct = ProductOffline();
  CacheSembastService sembestCache = Get.find<CacheSembastService>();

  void generateProductCode() {
    int test = DateTime.now().millisecondsSinceEpoch;
    productCode.text = test.toString();
  }

  importCsv() async {
    List<ProductOffline> products = [];
    FilePickerResult? file = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    try {
      if (file != null && file.files.isNotEmpty) {
        UINotification.showLoading();
        var bytes = await File(file.files.first.path!).readAsString();
        List<List<dynamic>> csvConverted =
            const CsvToListConverter().convert(bytes);

        ProductOffline temp = ProductOffline();
        for (var i = 1; i < csvConverted.length; i++) {
          temp.name = csvConverted[i][0];
          temp.code = csvConverted[i][1].toString();
          temp.barcodeSymbology = csvConverted[i][2];
          temp.brand = csvConverted[i][3];
          temp.category = csvConverted[i][4].toString();
          temp.unit = csvConverted[i][5];
          temp.defaultSaleUnit = csvConverted[i][6];
          temp.defaultPurchaseUnit = csvConverted[i][7];
          temp.cost = csvConverted[i][8];
          temp.price = csvConverted[i][9];
          temp.alertQuantity = csvConverted[i][10];
          temp.tax = csvConverted[i][11];
          temp.taxMethod = csvConverted[i][12];
          temp.productImage = csvConverted[i][13];
          temp.subCategory = csvConverted[i][14];
          temp.quantity = int.tryParse(csvConverted[i][22].toString());
          await sembestCache.setProductsOfflineData(temp);
        }
        UINotification.hideLoading();
        Get.defaultDialog(
          title: "Added",
          middleText: "New Product Added",
          middleTextStyle: TextStyle(color: Colors.black),
        );
      }
    } catch (e) {
      UINotification.hideLoading();
      Get.defaultDialog(
        title: "Something went wrong..",
        middleText: "Check the file..",
        middleTextStyle: TextStyle(color: Colors.black),
      );
    }
  }

  void addProductOffline() {
    offlineProduct.code = productCode.text;
    offlineProduct.name = productName.text;
    offlineProduct.price = int.tryParse(productPrice.text);
    offlineProduct.cost = int.tryParse(productCost.text);
    offlineProduct.quantity = int.tryParse(productQuantity.text);
    offlineProduct.category = selectedCategory;
    offlineProduct.tax = selectedTax;
    offlineProduct.unit = selectedTax;
    sembestCache.setProductsOfflineData(offlineProduct);
    Get.defaultDialog(
      title: "Added",
      middleText: "New Product Added",
      middleTextStyle: TextStyle(color: Colors.black),
    );
  }

  void importExcel() async {
    ExcelToJson().convert().then((onValue) async {
      try {
        UINotification.showLoading();
        List<dynamic> map = jsonDecode(onValue!);
        dynamic s;
        for (var item in map) {
          s = await sembestCache
              .setProductsOfflineData(ProductOffline.fromJson(item));
          logger.wtf(s);
        }
        UINotification.hideLoading();
        Get.defaultDialog(
          title: "Added",
          middleText: "New Product Added",
          middleTextStyle: TextStyle(color: Colors.black),
        );
      } catch (e) {
        UINotification.hideLoading();
      }
    });
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
    productName.dispose();
    productCode.dispose();
    productCost.dispose();
    productQuantity.dispose();
    productPrice.dispose();
  }

  void increment() => count.value++;
}

class ProductCategoryOption {
  final String key;
  final String fullName;

  ProductCategoryOption(this.key, this.fullName);

  static List<ProductCategoryOption> get allCategories => [
        ProductCategoryOption('1', 'Genaral'),
        ProductCategoryOption('2', 'Beverages'),
        ProductCategoryOption('3', 'Bread & Bakery'),
        ProductCategoryOption('4', 'Cookies,Snacks & Candy'),
        ProductCategoryOption('5', 'Durra'),
      ];
}

class ProductTaxOption {
  final String key;
  final String fullName;

  ProductTaxOption(this.key, this.fullName);

  static List<ProductTaxOption> get allTax => [
        ProductTaxOption('1', 'VAT@15'),
        ProductTaxOption('2', 'Zero Tax'),
      ];
}

class ProductUnitOption {
  final String key;
  final String fullName;

  ProductUnitOption(this.key, this.fullName);

  static List<ProductUnitOption> get allUnits => [
        ProductUnitOption('1', 'Piece(pc)'),
        ProductUnitOption('2', 'G - (gram) (G)'),
        ProductUnitOption('3', 'KG - (kilogram) (KG)'),
        ProductUnitOption('4', 'L - (litre) (L)'),
        ProductUnitOption('5', 'S - (set) (SET)'),
        ProductUnitOption('6', 'I - (item) (I)'),
        ProductUnitOption('7', 'H - (hour) (H)'),
        ProductUnitOption('8', 'E - (each) (E)'),
        ProductUnitOption('9', '10 (BOX)'),
      ];
}
