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

class DeliveryAddOrdersScreen extends StatelessWidget {
  const DeliveryAddOrdersScreen({Key? key}) : super(key: key);
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
                                    "Orders",
                                    style: CustomTextStyle.mainTitle,
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 15),
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
