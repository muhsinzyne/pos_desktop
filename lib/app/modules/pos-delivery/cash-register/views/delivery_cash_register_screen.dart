// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/infobox.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/quicklink.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryCashRegisterScreen extends StatelessWidget {
  const DeliveryCashRegisterScreen({Key? key}) : super(key: key);
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cash",
                                style: CustomTextStyle.mainTitle,
                              ),
                              Text(
                                "Register",
                                style: CustomTextStyle.mainTitle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InfoBox(
                                title: "OPEN BALANCE",
                                value: "00",
                                boxColor: Color(0xff4911C3),
                              ),
                              // SizedBox(
                              // width: 10,
                              // ),
                              InfoBox(
                                title: "CASH IN HAND",
                                value: "00",
                                boxColor: AppColors.deliveryPrimary,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Text(
                              "Quick Links",
                              style: CustomTextStyle.mainTitle,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.deliveryOpenRegister);
                            },
                            child: QuickLink(
                              title: "Open Register",
                              iconData: FontAwesomeIcons.openid,
                              iconSize: 35,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.deliveryCloseRegister);
                            },
                            child: QuickLink(
                              title: "Close Register",
                              iconData: Icons.cancel_outlined,
                              iconSize: 35,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.deliveryAmountTransfer);
                            },
                            child: QuickLink(
                              title: "Transfer Money",
                              iconData: Icons.reply_all_outlined,
                              iconSize: 35,
                            ),
                          ),
                          QuickLink(
                            title: "Register History",
                            iconData: Icons.list_alt_outlined,
                            iconSize: 35,
                          ),
                          QuickLink(
                            title: "Transfer History",
                            iconData: Icons.restore_outlined,
                            iconSize: 35,
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
