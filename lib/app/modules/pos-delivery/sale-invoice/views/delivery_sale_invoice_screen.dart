// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:posdelivery/app/modules/pos-delivery/sale-invoice/controllers/delivery_sale_invoice_controller.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/product_row.dart';

class DeliverySaleInvoiceScreen
    extends GetView<DeliverySaleInvoiceScreenController> {
  const DeliverySaleInvoiceScreen({Key? key}) : super(key: key);
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Invoice",
                                style: CustomTextStyle.mainTitle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return Text(
                              controller
                                  .invoiceResponse.value.inv!.orderDiscountId
                                  .toString()
                              // .toStringAsFixed(2),
                              ,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            );
                          }),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: controller.actionOnPrint,
                          child: Container(
                            height: 85,
                            width: Constants.screenWidth / 2,
                            color: AppColors.deliverySecondary,
                            child: Center(
                                child: Text(
                              "PDF",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        ),
                        Container(
                          height: 85,
                          width: Constants.screenWidth / 2,
                          color: AppColors.deliveryPrimary,
                          child: Center(
                              child: Text(
                            "Home",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
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
