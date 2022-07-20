// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryAddStoreManuallyScreen extends StatelessWidget {
  const DeliveryAddStoreManuallyScreen({Key? key}) : super(key: key);
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
                            hint: "Customer Groupas",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(
                            hint: "Price Group",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(hint: "Store Name"),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(hint: "Company Name"),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(hint: "GST/VAT Number"),
                          SizedBox(
                            height: 8,
                          ),
                          TextFieldDelivery(hint: "Phone Number"),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: TextFieldDelivery(hint: "Place"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
                                  decoration: BoxDecoration(
                                      color: Color(0xB3BABFC4),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: AppColors.deliveryPrimary,
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
                            hint: "Address",
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 85,
                      width: double.infinity,
                      color: AppColors.deliveryPrimary,
                      child: Center(
                          child: Text(
                        "Add Store",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
