// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';

import '../../../../../models/constants.dart';

class DeliverySalesPaymentScreen extends StatelessWidget {
  const DeliverySalesPaymentScreen({Key? key}) : super(key: key);

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sales",
                            style: CustomTextStyle.mainTitle,
                          ),
                          Text(
                            "Payment",
                            style: CustomTextStyle.mainTitle,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sales Total"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery()
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Payment Amount"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Balance"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Change"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Due Date"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(),
                            ],
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
                        "Confirm",
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
