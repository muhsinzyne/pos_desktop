// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryAddProductsScreen extends StatelessWidget {
  const DeliveryAddProductsScreen({Key? key}) : super(key: key);
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
                                    "Product",
                                    style: CustomTextStyle.mainTitle,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.close,
                                size: 43,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFieldDelivery(
                            hint: "Product Name",
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFieldDelivery(
                            hint: "Quantity",
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFieldDelivery(
                            hint: "Unit (box/piece/...)",
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFieldDelivery(
                            hint: "Rate (price/unit)",
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.maxFinite,
                            child: AspectRatio(
                              aspectRatio: 1.6 / 1,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            AutoSizeText(
                                              "2467.00",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            )
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
                                            AutoSizeText(
                                              "643",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            )
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tax Peercentage",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                            AutoSizeText(
                                              "11%",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            )
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
                                            AutoSizeText(
                                              "240",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            )
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
                                            AutoSizeText(
                                              "29219.00",
                                              style: CustomTextStyle.mainTitle
                                                  .copyWith(fontSize: 17),
                                            )
                                          ]),
                                    ]),
                              ),
                            ),
                          ),
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
                            "Add New",
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
                              "Add",
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
