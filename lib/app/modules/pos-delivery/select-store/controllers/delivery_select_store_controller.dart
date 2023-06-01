import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/select-store/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:get/get.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';

class DeliverySelectStoreScreenController extends BaseGetXController
    implements IDeliverySelectStoreController {
  CacheSembastDeliveryService sembastCache =
      Get.find<CacheSembastDeliveryService>();

  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  RxBool isQrOpen = false.obs;
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  RxList<WarehouseListResponse> warehouseList = RxList([]);

  void init() async {
    dynamic temp = await sembastCache.getAllwarehouses();
    // if (temp.length != 0) {
    //   warehouseList.addAll(temp);
    //   UINotification.hideLoading();
    // } else {
    //   logger.e('api');
    //   deliveryDataProvider.getStores();
    // }
  }

  void toggleCamera() {
    isQrOpen.value = !isQrOpen.value;
    // scanQR();
  }

  scanQR(String qrString) async {
    try {
      StoreAddRequest storeAddrequest =
          StoreAddRequest.fromJson(jsonDecode(qrString));
      await sembastCache.setAddstoreFormData(storeAddrequest);
      Get.defaultDialog(
        title: "Added",
        middleText: "New Store added localy",
        middleTextStyle: TextStyle(color: Colors.black),
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Something went wrong",
        middleText: "the QrCode not is proper format",
        middleTextStyle: TextStyle(color: Colors.black),
      );
    }
  }

  @override
  void onInit() async {
    deliveryDataProvider.deliverySelectStoreCallBack = this;
    init();
    super.onInit();
  }

  @override
  void onReady() {
    UINotification.showLoading();
    super.onReady();
  }

  @override
  onWarehousetListDone(List<WarehouseListResponse> warehouseRes) {
    warehouseList.addAll(warehouseRes);
    warehouseList.forEach((element) {
      logger.e(element.map);
    });
    UINotification.hideLoading();
  }

  @override
  onWarehousetListError(ErrorMessage err) {
    logger.e(err.message);
  }
}
