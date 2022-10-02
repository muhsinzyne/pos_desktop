import 'dart:convert';

import 'package:get/get.dart';
import 'package:posdelivery/app/modules/connect_printer/bindings/connect_printer_binding.dart';
import 'package:posdelivery/app/modules/connect_printer/controllers/connect_printer_controller.dart';
import 'package:posdelivery/app/modules/home/controllers/home_controller.dart';
import 'package:posdelivery/app/modules/pos/add-product/controllers/product_suggestion_controller.dart';
import 'package:posdelivery/controllers/app_controller.dart';
import 'package:posdelivery/models/enums.dart';
import 'package:posdelivery/providers/data/auth_data_provider.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/providers/data/desktop_data_provider.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/providers/local/blue_thermal_print_provider.dart';
import 'package:posdelivery/providers/local/pdf_invoice_provider.dart';
import 'package:posdelivery/providers/local/print_provider.dart';
import 'package:posdelivery/providers/local/thermal_invoice_provider.dart';
import 'package:posdelivery/services/app_service.dart';
import 'package:posdelivery/services/base/network.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/cache/cache_sembast_service.dart';
import 'package:posdelivery/services/storage/sembast_delivery_storage_service.dart';
import 'package:posdelivery/services/storage/sembast_storage_service.dart';
import 'package:posdelivery/services/storage/local_storage_service.dart';

import '../providers/local/pdf_small_invoice_provider.dart';

class AppServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LocalStorage());
    Get.put(AppService());
    Get.put(AppController());
    Get.lazyPut(() => DioNetwork());
    Get.lazyPut<AuthDataProvider>(() => AuthDataProvider());
    // Get.put(PrintProvider());
    Get.put<PosDataProvider>(PosDataProvider());
    Get.put<DesktopDataProvider>(DesktopDataProvider());
    Get.put<DeliveryDataProvider>(DeliveryDataProvider());
    Get.put<BlueThermalPrinterProdvider>(BlueThermalPrinterProdvider());
    Get.put<ProductSuggestionController>(ProductSuggestionController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PdfInvoiceProvider>(() => PdfInvoiceProvider());
    Get.lazyPut<ConnectPrinterController>(() => ConnectPrinterController());
    Get.lazyPut<ThermalInvoiceProvider>(() => ThermalInvoiceProvider());
    Get.put<CacheService>(
        CacheService(cacheAdaptor: CacheAdaptor.localStorage));
    Get.lazyPut(() => SembastStorage().init());
    Get.lazyPut(() => SembastDeliveryStorage().init());
    Get.lazyPut(() => PrintProvider());
    Get.lazyPut(() => PdfInvoiceProvider());
    Get.put(CacheSembastService());
    Get.put(CacheSembastDeliveryService());
  }
}

void dummyFunction() {
  print("dummyFunction() triggered");
}

var dummyBytes = base64Decode('');
