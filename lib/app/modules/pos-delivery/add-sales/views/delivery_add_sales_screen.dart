// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:posdelivery/app/modules/pos/pos_bill/views/pos_bill_screen.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/productTile.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryAddSalesScreen extends StatelessWidget {
  const DeliveryAddSalesScreen({Key? key}) : super(key: key);
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sales",
                                    style: CustomTextStyle.mainTitle,
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.deliveryPrimary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "Add Product",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xffDFD7E8),
                                borderRadius: BorderRadius.circular(20)),
                            child: AspectRatio(
                              aspectRatio: 1.3 / 1,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20, top: 20),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Pre Order",
                                          style: CustomTextStyle.mainTitle
                                              .copyWith(fontSize: 17),
                                        )),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Products",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              "2467.00",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            )
                                          ]),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Quantity",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              "643",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            )
                                          ]),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Tax ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              "11%",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            )
                                          ]),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Sub Total",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              "240",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Grand Total",
                                              style: CustomTextStyle.mainTitle
                                                  .copyWith(fontSize: 17),
                                            ),
                                            Text(
                                              "29219.00",
                                              style: CustomTextStyle.mainTitle
                                                  .copyWith(fontSize: 17),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      // height: 20,
                                      decoration: BoxDecoration(
                                        color: AppColors.deliveryPrimary,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Container(
                                              padding: EdgeInsets.all(14),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Detailed View",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_right_outlined,
                                                      color: Colors.white,
                                                    )
                                                  ]))),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            "New Order",
                            style: CustomTextStyle.mainTitle,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DeliveyProductTile(),
                          DeliveyProductTile(),
                          DeliveyProductTile(),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 85,
                          width: Constants.screenWidth / 2,
                          color: AppColors.deliverySecondary,
                          child: Center(
                              child: Text(
                            "29,383.00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                        Container(
                          height: 85,
                          width: Constants.screenWidth / 2,
                          color: AppColors.deliveryPrimary,
                          child: Center(
                            child: Text(
                              "Proceed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
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
