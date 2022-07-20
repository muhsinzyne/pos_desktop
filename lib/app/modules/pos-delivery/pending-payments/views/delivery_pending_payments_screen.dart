// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import '../../../../../models/constants.dart';
import 'package:flutter_switch/flutter_switch.dart';

class DeliveryPendingPaymentScreen extends StatefulWidget {
  DeliveryPendingPaymentScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryPendingPaymentScreen> createState() =>
      _DeliveryPendingPaymentScreenState();
}

class _DeliveryPendingPaymentScreenState
    extends State<DeliveryPendingPaymentScreen> {
  final List<String> _dropdownValues = [
    "Today",
    "Two",
    "Three",
    "Four",
    "Five"
  ];
  bool status = false;
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pending  ",
                                      style: CustomTextStyle.mainTitle,
                                    ),
                                    Text(
                                      "Payments",
                                      style: CustomTextStyle.mainTitle,
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 25),
                                  decoration: BoxDecoration(
                                    color: AppColors.deliveryPrimary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Pay",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xffE5E5E5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Invoice",
                                        style: CustomTextStyle.mainTitle
                                            .copyWith(fontSize: 18),
                                      ),
                                      Text(
                                        "#9475898",
                                        style: CustomTextStyle.mainTitle
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Amount",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text(
                                        "5898.00",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Due Date",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text(
                                        "22 March 2022",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: double.infinity,
                                  // height: 20,
                                  decoration: BoxDecoration(
                                    color: AppColors.deliverySecondary80,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                  ),
                                  child: Center(
                                      child: Container(
                                          padding: EdgeInsets.all(14),
                                          child: Text(
                                            "Pay",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xffE5E5E5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Invoice",
                                        style: CustomTextStyle.mainTitle
                                            .copyWith(fontSize: 18),
                                      ),
                                      Text(
                                        "#9475898",
                                        style: CustomTextStyle.mainTitle
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Amount",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text(
                                        "5898.00",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Due Date",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text(
                                        "22 March 2022",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: double.infinity,
                                  // height: 20,
                                  decoration: BoxDecoration(
                                    color: AppColors.deliverySecondary80,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                  ),
                                  child: Center(
                                      child: Container(
                                          padding: EdgeInsets.all(14),
                                          child: Text(
                                            "Pay",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                )
                              ],
                            ),
                          ),
                        ],
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
