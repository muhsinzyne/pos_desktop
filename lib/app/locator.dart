import 'dart:convert';

import 'package:get/get.dart';
import 'package:posdelivery/app/modules/home/controllers/home_controller.dart';
import 'package:posdelivery/app/modules/pos/add-product/controllers/product_suggestion_controller.dart';
import 'package:posdelivery/controllers/app_controller.dart';
import 'package:posdelivery/models/enums.dart';
import 'package:posdelivery/providers/data/auth_data_provider.dart';
import 'package:posdelivery/providers/data/desktop_data_provider.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/services/app_service.dart';
import 'package:posdelivery/services/base/network.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/storage/app_storage_service.dart';
import 'package:posdelivery/services/storage/local_storage_service.dart';

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
    Get.put<ProductSuggestionController>(ProductSuggestionController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<CacheService>(
        CacheService(cacheAdaptor: CacheAdaptor.localStorage));
    Get.lazyPut(() => AppDatabase().init());
  }
}

void dummyFunction() {
  print("dummyFunction() triggered");
}

var dummyBytes = base64Decode('');
