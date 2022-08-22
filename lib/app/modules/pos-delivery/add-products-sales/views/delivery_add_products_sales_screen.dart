// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-order/controllers/delivery_add_products_order_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-products-sales/controllers/delivery_add_products_sales_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/units.dart';

class DeliveryAddProductsSalesScreen
    extends GetView<DeliveryAddProductsSalesScreenController> {
  const DeliveryAddProductsSalesScreen({Key? key}) : super(key: key);
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add",
                                    style: CustomTextStyle.mainTitle,
                                  ),
                                  Text(
                                    "Product Sale",
                                    style: CustomTextStyle.mainTitle,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 43,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFieldDelivery(
                            controller: controller.productName,
                            hint: "Product Name",
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFieldDelivery(
                            controller: controller.quantity,
                            hint: "Quantity",
                          ),
                          SizedBox(
                            height: 18,
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
                            child: Obx(() {
                              return DropdownButtonFormField<Units>(
                                decoration: InputDecoration(
                                    hintText: "Unit (box/piece/..)",
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  controller.selectedUnit = value;
                                  controller.calculateTotal();
                                },
                                items: controller.units.map((selectedType) {
                                  return DropdownMenuItem<Units>(
                                    child: Text(
                                      selectedType.name!,
                                    ),
                                    value: selectedType,
                                  );
                                }).toList(),
                              );
                            }),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFieldDelivery(
                            controller: controller.price,
                            hint: "Rate (price/unit)",
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.maxFinite,
                            height: Constants.screenHeight * 0.4,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.deliverySecondaryLight),
                                color: Color(0xffDFD7E8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: AutoSizeText(
                                          "Total",
                                          style: CustomTextStyle.mainTitle
                                              .copyWith(fontSize: 17),
                                        )),
                                    SizedBox(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Sub Total (rate x Qty)",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                          Obx(() {
                                            return AutoSizeText(
                                              controller.subTotal.value,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            );
                                          })
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Discount",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                          Obx(() {
                                            return AutoSizeText(
                                              controller.discount.value,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            );
                                          })
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tax Percentage",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                          Obx(() {
                                            return AutoSizeText(
                                              controller.taxPercentage.value,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            );
                                          })
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tax Amount",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54),
                                          ),
                                          Obx(() {
                                            return AutoSizeText(
                                              controller.taxAmount.value,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            );
                                          })
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Amount",
                                            style: CustomTextStyle.mainTitle
                                                .copyWith(fontSize: 17),
                                          ),
                                          Obx(() {
                                            return AutoSizeText(
                                              controller.totalAmount.value,
                                              style: CustomTextStyle.mainTitle
                                                  .copyWith(fontSize: 17),
                                            );
                                          })
                                        ]),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              controller.isAddNew = true;
                              controller.addNew();
                            },
                            child: Container(
                              height: 85,
                              // width: Constants.screenWidth / 2,
                              color: AppColors.deliverySecondary,
                              child: Center(
                                  child: Text(
                                "Add New",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              controller.isAddNew = false;
                              controller.addAsExist();
                            },
                            child: Container(
                              height: 85,
                              // width: Constants.screenWidth / 2,
                              color: AppColors.deliveryPrimary,
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
