import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/add-store/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/requests/customer/customer_add_request.dart';
import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/location_service.dart';
import 'dart:async';

class NewAddStoreScreenController extends BaseGetXController
    implements INewStoreAddScreenController {
  final TextEditingController storeName = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController gst_vatNumber = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController place = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController lat = TextEditingController();
  final TextEditingController long = TextEditingController();
  late String latitude = "";
  late String longitude = "";

  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  CustomerAddRequest storeAddRequest = CustomerAddRequest();

  List<CustomerOption> customerCategory = CustomerOption.allCustomer;
  List<PriceOption> priceCategory = PriceOption.allPrices;

  String? customerGroup;
  String? priceGroup;

  void addData() async {
    storeAddRequest.email = email.text;
    // storeAddRequest.latitude = latitude;
    // storeAddRequest.longitude = longitude;
    storeAddRequest.city = place.text;
    storeAddRequest.customerGroup = customerGroup;
    storeAddRequest.priceGroup = priceGroup;
    storeAddRequest.name = storeName.text;
    storeAddRequest.company = companyName.text;
    storeAddRequest.vatNo = gst_vatNumber.text;
    storeAddRequest.phone = phoneNumber.text;
    storeAddRequest.address = address.text;
    deliveryDataProvider.customerAddRequest(storeAddRequest);
  }

  void vaidate() async {
    if (customerGroup != null &&
            // priceGroup!.isNotEmpty &&
            storeName.text.isNotEmpty &&
            companyName.text.isNotEmpty &&
            gst_vatNumber.text.isNotEmpty &&
            phoneNumber.text.isNotEmpty &&
            email.text.isNotEmpty
        // place.text.isNotEmpty &&
        // address.text.isNotEmpty

        // latitude.isNotEmpty &&
        // longitude.isNotEmpty
        ) {
      addData();
    } else {
      Get.snackbar("title", "enter all fields");
    }
  }

  //lifecycles method
  @override
  void onInit() async {
    deliveryDataProvider.newStoreAddCallBack = this;
    super.onInit();
  }


  @override
  void onClose() {
    print("fd");
    storeName.dispose();
    companyName.dispose();
    gst_vatNumber.dispose();
    place.dispose();
    address.dispose();
    email.dispose();
    lat.dispose();
    long.dispose();
    super.onClose();
  }

  //contracts

  @override
  onCustomerAddDone(CustomerAddResponse cListRes) {
    Get.defaultDialog(
      title: "",
      content: SizedBox(
        width: 300,
        child: Column(
          children: [
            SvgPicture.asset("assets/svg/tick.svg",
                semanticsLabel: 'Acme Logo'),
            SizedBox(
              height: 10,
            ),
            Text("${cListRes.data!.name}:New Store Added"),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: Get.back,
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deliveryPrimary80,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  onCustomerAddError(ErrorMessage err) {
    Get.snackbar("failed", err.message ?? "Something went wrong");
  }
}

class CustomerOption {
  final String key;
  final String fullName;

  CustomerOption(this.key, this.fullName);

  static List<CustomerOption> get allCustomer => [
        CustomerOption('1', 'Default'),
        CustomerOption('2', 'Route Cusomter'),
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
