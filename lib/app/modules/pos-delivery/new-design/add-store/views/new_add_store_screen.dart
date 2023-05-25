// ignore_for_file: prefer_const_constructors

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/add-store/controllers/new_add_store_controller.dart';
import 'package:logger/logger.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class NewAddStoreScreen extends GetView<NewAddStoreScreenController> {
  bool validate = false;
  NewAddStoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true ,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.newSecondary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SvgPicture.asset(
                "assets/svg/menu.svg",
                color: AppColors.newIconColor,
                height: 30,
                width: 30,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(icon: SizedBox(), label: ""),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                "assets/svg/back.svg",
                height: 30,
                width: 30,
              ),
            ),
            label: '',
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            child: SvgPicture.asset(
              "assets/svg/store-add.svg",
              fit: BoxFit.fitHeight,
            ),
            backgroundColor: AppColors.newSecondary,
            onPressed: null,
          ),
        ),
      ),
      appBar: DeliveryAppBar(
        appBar: AppBar(),
      ),
      backgroundColor: AppColors.newBg,
      body: SafeArea(
      child:
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("ADD NEW STORE",
                                style: CustomTextStyle.mainTitle.copyWith(
                                    color: const Color(0xff454E52))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      flex: 15,
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5)
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          border: Border.all(
                                              color:
                                                  AppColors.deliverySecondary,
                                              width: 0,
                                              style: BorderStyle.solid)),
                                      child: DropdownButtonFormField<
                                          CustomerOption>(
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
                                          return DropdownMenuItem<
                                              CustomerOption>(
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
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5)
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          border: Border.all(
                                              color:
                                                  AppColors.deliverySecondary,
                                              width: 0,
                                              style: BorderStyle.solid)),
                                      child:
                                          DropdownButtonFormField<PriceOption>(
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
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color(0xffE5E5E5)
                                              .withOpacity(0.3),
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          border: Border.all(
                                              color:
                                              AppColors.deliverySecondary,
                                              width: 0,
                                              style: BorderStyle.solid)),
                                      child:
                                      DropdownButtonFormField<BusinessType>(
                                        decoration: InputDecoration(
                                            hintText: "Business Type",
                                            enabledBorder: InputBorder.none,
                                            border: InputBorder.none),
                                        onChanged: (value) {
                                          controller.priceGroup =
                                              value!.name.toString();
                                        },
                                        items: controller.businessTypeCategory
                                            .map((selectedType) {
                                          return DropdownMenuItem<BusinessType>(
                                            child: Text(
                                              selectedType.name,
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
                                TextFieldDelivery(
                                  controller: controller.email,
                                  hint: "Email",
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
                                        onTap:(){ controller.getLocation();},
                                        child: SvgPicture.asset(
                                            "assets/svg/location.svg"),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFieldDelivery(
                                  maxLine: 2,
                                  controller: controller.address,
                                  hint: "Address",
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.validate();
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 30,
                                        width: 85,
                                        decoration: BoxDecoration(
                                            color: AppColors.deliveryPrimary,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        child: Center(
                                            child: Text(
                                          "Save",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),

      ),
    );
  }
}
