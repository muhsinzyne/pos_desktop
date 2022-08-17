import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/contracts.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/location_service.dart';
import 'dart:async';

class DeliveryAddStoreManuallyScreenController extends BaseGetXController
    implements IDeliveryStoreAddController {
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
  // bool isOnline = false;
  // late String country;
  // late String postalCode;
  // late String state;
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  StoreAddRequest storeAddRequest = StoreAddRequest();
  CacheSembastDeliveryService sembastCache =
      Get.find<CacheSembastDeliveryService>();

  List<StoreAddRequest> formData = [];

  List<CustomerOption> customerCategory = CustomerOption.allCustomer;
  List<PriceOption> priceCategory = PriceOption.allPrices;

  String? customerGroup;
  String? priceGroup;
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
    storeAddRequest.customerGroup = customerGroup;
    storeAddRequest.priceGroup = priceGroup;
    storeAddRequest.name = storeName.text;
    storeAddRequest.company = companyName.text;
    storeAddRequest.vatNo = gst_vatNumber.text;
    storeAddRequest.phone = phoneNumber.text;
    storeAddRequest.address = address.text;
    if (isOnline) {
      deliveryDataProvider.storeAddRequest(storeAddRequest);
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
    if (customerGroup!.isNotEmpty &&
        priceGroup!.isNotEmpty &&
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
    storeName.dispose();
    companyName.dispose();
    gst_vatNumber.dispose();
    place.dispose();
    address.dispose();
    email.dispose();
    super.onClose();
  }

  @override
  onStoreAddDone(StoreAddResponse customerAddResponse) {
    Get.snackbar("Saved", "Saved Succesfully");
  }

  @override
  onStoreAddError(ErrorMessage err) {
    // TODO: implement onStoreAddError
    throw UnimplementedError();
  }
}

class CustomerOption {
  final String key;
  final String fullName;

  CustomerOption(this.key, this.fullName);

  static List<CustomerOption> get allCustomer => [
        CustomerOption('1', 'Route Cusomter'),
      ];
}

class PriceOption {
  final String key;
  final String fullName;

  PriceOption(this.key, this.fullName);

  static List<PriceOption> get allPrices => [
        PriceOption('1', 'Exclusive'),
        PriceOption('2', 'Offer25'),
      ];
}
