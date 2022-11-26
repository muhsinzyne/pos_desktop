// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-sales/controllers/delivery_sales_controller.dart';
import 'package:posdelivery/app/modules/pos/pos_bill/views/pos_bill_screen.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/productTile.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliverySalesScreen extends GetView<DeliverySalesScreenController> {
  const DeliverySalesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.init();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(Routes.deliveryStoreDetails);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
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
                                      "Cart Items",
                                      style: CustomTextStyle.mainTitle,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () async {
                                    Get.toNamed(
                                        Routes.deliveryProductsForSales);
                                  },
                                  child: Container(
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
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Obx(() {
                              return controller.cartItems.length != 0
                                  ? Container(
                                      width: double.infinity,
                                      height: Constants.screenHeight * 0.3,
                                      decoration: BoxDecoration(
                                          color: Color(0xffDFD7E8),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: AspectRatio(
                                        aspectRatio: 1.3 / 1,
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 20),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    "Pre Order",
                                                    style: CustomTextStyle
                                                        .mainTitle
                                                        .copyWith(fontSize: 17),
                                                  )),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Products",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Obx(() {
                                                        return Text(
                                                          controller
                                                              .totalProducts
                                                              .value,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black54),
                                                        );
                                                      })
                                                    ]),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Total Quantity",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Obx(() {
                                                        return Text(
                                                          controller
                                                              .totalQuantity
                                                              .value,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black54),
                                                        );
                                                      })
                                                    ]),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Total Tax ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Obx(() {
                                                        return Text(
                                                          controller
                                                              .totalTax.value,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black54),
                                                        );
                                                      })
                                                    ]),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Sub Total",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Obx(() {
                                                        return Text(
                                                          controller
                                                              .subTotal.value,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black54),
                                                        );
                                                      })
                                                    ]),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Grand Total",
                                                        style: CustomTextStyle
                                                            .mainTitle
                                                            .copyWith(
                                                                fontSize: 17),
                                                      ),
                                                      Obx(() {
                                                        return Text(
                                                          controller
                                                              .grandTotal.value,
                                                          style: CustomTextStyle
                                                              .mainTitle
                                                              .copyWith(
                                                                  fontSize: 17),
                                                        );
                                                      })
                                                    ]),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                // height: 20,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.deliveryPrimary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20)),
                                                ),
                                                child: Center(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(14),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Detailed View",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .arrow_right_outlined,
                                                                color: Colors
                                                                    .white,
                                                              )
                                                            ]))),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(width: 0, height: 0);
                            }),
                            SizedBox(
                              height: 35,
                            ),
                            Obx(() {
                              return Container(
                                  height: Constants.screenHeight * 0.3,
                                  width: Constants.screenWidth,
                                  child: ListView.builder(
                                    itemCount: controller.cartItems.length,
                                    itemBuilder: (context, i) => InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.deliverySalesPayment,
                                            arguments: {
                                              "key":
                                                  controller.cartItems[i].key!,
                                              "code":
                                                  controller.cartItems[i].itemId
                                            });
                                      },
                                      child: DeliveyProductTile(
                                          id: i,
                                          item: controller.cartItems[i],
                                          delete: controller.deleteCartItem,
                                          productName: controller
                                              .cartItems[i].cartItem!.label!,
                                          price: controller
                                              .cartItems[i].cartItem!.row!.price
                                              .toString(),
                                          qty: controller.cartItems[i].quantity
                                              .toString(),
                                          tax: controller.cartItems[i].tax
                                              .toString(),
                                          totalPrice: controller
                                              .cartItems[i].grandTotal
                                              .toString()),
                                    ),
                                  ));
                            })
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
                              child: Obx(() {
                                return Text(
                                  controller.grandTotal.value,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                );
                              }),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.deliverySalesPayment);
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
      ),
    );
  }
}
