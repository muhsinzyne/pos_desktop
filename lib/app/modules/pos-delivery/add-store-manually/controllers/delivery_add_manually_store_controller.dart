import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/location_service.dart';
import 'dart:async';

class DeliveryAddStoreManuallyScreenController extends BaseGetXController {
  final TextEditingController customerGroup = TextEditingController();
  final TextEditingController priceGroup = TextEditingController();
  final TextEditingController storeName = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController gst_vatNumber = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController place = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController email = TextEditingController();
  late String latitude = "23.232";
  late String longitude = "67.232";

  late bool isOnline;
  // late String country;
  // late String postalCode;
  // late String state;
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  StoreAddRequest storeAddRequest = StoreAddRequest();
  CacheSembastDeliveryService sembastCache =
      Get.find<CacheSembastDeliveryService>();

  List<StoreAddRequest> formData = [];

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
  void cacheOrInsert() async {
    storeAddRequest.email = email.text;
    storeAddRequest.latitude = latitude;
    storeAddRequest.longitude = longitude;
    storeAddRequest.city = place.text;
    storeAddRequest.customerGroup = customerGroup.text;
    storeAddRequest.priceGroup = priceGroup.text;
    storeAddRequest.name = storeName.text;
    storeAddRequest.company = companyName.text;
    storeAddRequest.vatNo = gst_vatNumber.text;
    storeAddRequest.phone = phoneNumber.text;
    storeAddRequest.address = address.text;
    if (isOnline) {
      deliveryDataProvider.storeAddRequest(storeAddRequest);
      Get.snackbar("Saved", "Saved Succesfully");
    } else {
      await sembastCache.setAddstoreFormData(storeAddRequest);
      Get.snackbar("internet",
          "No internet data will be added when internet is available");
    }
  }

  void init() async {
    isOnline = await hasNetwork();
    if (isOnline) {
      formData = await sembastCache.getAddstoreFormData();
      logger.w(formData.length);
      if (formData.isNotEmpty) {
        var i;
        for (i = 0; i < formData.length; i++) {
          deliveryDataProvider.storeAddRequest(formData[i]);
        }
        await sembastCache.deleteAddStoreFormData();
        Get.snackbar("Cached", "Cached $i requests is Saved Succesfully");
      }
    }
  }

  void getLocation() async {
    Position data = await determinePosition();
    latitude = data.latitude.toString();
    longitude = data.longitude.toString();
    // Address address = await cordToAdress(lat: data.latitude, long: data.longitude);
    // place.text = address.city!;
    // country = address.countryName!;
    // postalCode = address.postal!;
    // state = address.region!;
  }

  void vaidate() async {
    if (customerGroup.text.isNotEmpty &&
        priceGroup.text.isNotEmpty &&
        storeName.text.isNotEmpty &&
        companyName.text.isNotEmpty &&
        gst_vatNumber.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty &&
        place.text.isNotEmpty &&
        address.text.isNotEmpty &&
        latitude.isNotEmpty &&
        longitude.isNotEmpty) {
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
    customerGroup.dispose();
    priceGroup.dispose();
    storeName.dispose();
    companyName.dispose();
    gst_vatNumber.dispose();
    place.dispose();
    address.dispose();
    email.dispose();
    super.onClose();
  }
}
