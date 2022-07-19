// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/quicklink.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryPaymentHomeScreen extends StatelessWidget {
  const DeliveryPaymentHomeScreen({Key? key}) : super(key: key);
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
                              Text(
                                "Payments",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                            width: double.infinity,
                            child: AspectRatio(
                              aspectRatio: 2.9 / 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                decoration: BoxDecoration(
                                    color: AppColors.deliveryPrimary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "873488.78",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "DUE AMOUNT",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Text(
                              "Quick Links",
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          QuickLink(
                            title: "Pay",
                            iconData: FontAwesomeIcons.moneyCheck,
                          ),
                          QuickLink(
                              title: "Pending Payments",
                              iconData: Icons.attach_money_outlined),
                          QuickLink(
                            title: "Pending History",
                            iconData: Icons.history,
                          ),
                          QuickLink(
                            title: "Settings",
                            iconData: Icons.settings_outlined,
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
