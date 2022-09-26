// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/productTile.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryOrdersScreen extends StatelessWidget {
  const DeliveryOrdersScreen({Key? key}) : super(key: key);
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
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        Routes.deliveryProductsForOrders);
                                  },
                                  child: Text(
                                    "Add Product",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          // DeliveyProductTile(),
                          Slidable(
                            actionExtentRatio: .25,
                            // showAllActionsThreshold: ,
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'edit',
                                color: Colors.blue,
                                icon: Icons.edit,
                                onTap: () {
                                  // controller.actionOnEditRequest(cInfo);
                                },
                                closeOnTap: true,
                              ),
                              IconSlideAction(
                                caption: 'delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  // delete(id, item);
                                },
                                closeOnTap: true,
                              ),
                            ],
                            actionPane: SlidableDrawerActionPane(),
                            child: Column(children: [
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "productName",
                                      maxLines: 3,
                                      style: CustomTextStyle.mainTitle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    "totalPrice",
                                    style: CustomTextStyle.mainTitle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Pric",
                                    style: CustomTextStyle.mainTitle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff5E6164),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ]),
                          ),
                          Slidable(
                            actionExtentRatio: .25,
                            // showAllActionsThreshold: ,
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'edit',
                                color: Colors.blue,
                                icon: Icons.edit,
                                onTap: () {
                                  // controller.actionOnEditRequest(cInfo);
                                },
                                closeOnTap: true,
                              ),
                              IconSlideAction(
                                caption: 'delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  // delete(id, item);
                                },
                                closeOnTap: true,
                              ),
                            ],
                            actionPane: SlidableDrawerActionPane(),
                            child: Column(children: [
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "product 1",
                                      maxLines: 3,
                                      style: CustomTextStyle.mainTitle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    "totalPrice",
                                    style: CustomTextStyle.mainTitle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Pric",
                                    style: CustomTextStyle.mainTitle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff5E6164),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ]),
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
                            "29,383.00",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.deliveryOrderPayment);
                          },
                          child: Container(
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
