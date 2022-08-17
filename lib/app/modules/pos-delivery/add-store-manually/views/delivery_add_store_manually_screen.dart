// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import '../controllers/delivery_add_manually_store_controller.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryAddStoreManuallyScreen
    extends GetView<DeliveryAddStoreManuallyScreenController> {
  bool validate = false;
  DeliveryAddStoreManuallyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: const Text("New Store",
                                    style: CustomTextStyle.mainTitle),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFieldDelivery(
                            controller: controller.email,
                            hint: "email",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                    color: Color(0x99E5E5E5),
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: AppColors.deliverySecondary,
                                        width: 0,
                                        style: BorderStyle.solid)),
                                child: DropdownButtonFormField<CustomerOption>(
                                  decoration: InputDecoration(
                                      hintText: "Customer group",
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                  onChanged: (value) {
                                    controller.customerGroup =
                                        value!.key.toString();
                                  },
                                  items: controller.customerCategory
                                      .map((selectedType) {
                                    return DropdownMenuItem<CustomerOption>(
                                      child: Text(
                                        selectedType.fullName,
                                      ),
                                      value: selectedType,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                    color: Color(0x99E5E5E5),
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: AppColors.deliverySecondary,
                                        width: 0,
                                        style: BorderStyle.solid)),
                                child: DropdownButtonFormField<PriceOption>(
                                  decoration: InputDecoration(
                                      hintText: "Price Group",
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                  onChanged: (value) {
                                    controller.priceGroup =
                                        value!.key.toString();
                                  },
                                  items: controller.priceCategory
                                      .map((selectedType) {
                                    return DropdownMenuItem<PriceOption>(
                                      child: Text(
                                        selectedType.fullName,
                                      ),
                                      value: selectedType,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(
                            controller: controller.storeName,
                            hint: "Store Name",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(
                            controller: controller.companyName,
                            hint: "Company Name",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(
                            hint: "GST/VAT Number",
                            controller: controller.gst_vatNumber,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(
                            controller: controller.phoneNumber,
                            hint: "Phone Number",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: TextFieldDelivery(
                                  controller: controller.place,
                                  hint: "Place",
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: controller.getLocation,
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 16, 10, 16),
                                    decoration: BoxDecoration(
                                        color: Color(0xB3BABFC4),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      color: AppColors.deliveryPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(
                            maxLine: 4,
                            controller: controller.address,
                            hint: "Address",
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.vaidate();
                      },
                      child: Container(
                        height: 85,
                        width: double.infinity,
                        color: AppColors.deliveryPrimary,
                        child: Center(
                            child: Text(
                          "test",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
