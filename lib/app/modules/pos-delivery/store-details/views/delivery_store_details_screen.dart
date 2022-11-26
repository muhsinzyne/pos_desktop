// ignore_for_file: unnecessary_const, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/quicklink.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryStoreDetailsScreen extends StatelessWidget {
  const DeliveryStoreDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.deliveryHome);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.deliveryPrimary,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            bottom: false,
            top: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      // height: 20,
                      ),
                  Container(
                    height: Constants.screenHeight / 1.9,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.deliveryPrimary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: Constants.screenHeight * 0.06),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Constants.screenHeight / 13,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "Store Name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                AutoSizeText(
                                  "Place",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Constants.screenHeight / 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "GST Number",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                AutoSizeText(
                                  "Contact Number",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: AutoSizeText("Quick Links",
                              style: CustomTextStyle.mainTitle),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.deliverySelectStore);
                          },
                          child: QuickLink(
                            title: "Add Stores",
                            iconData: Icons.storefront_outlined,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.deliverySales);
                          },
                          child: QuickLink(
                            title: "Sales",
                            iconData: FontAwesomeIcons.tag,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.deliveryPaymentHome);
                          },
                          child: QuickLink(
                              title: "Payment",
                              iconData: Icons.payment_outlined),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        QuickLink(title: "Returns", iconData: Icons.loop_sharp),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.deliveryOrders);
                          },
                          child: QuickLink(
                            title: "Orders",
                            iconData: Icons.add_shopping_cart,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
