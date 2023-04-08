// ignore_for_file: prefer_const_constructors

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/add-store/controllers/new_add_store_controller.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/dashboard/controllers/new_dashboard_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dashboard_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class NewDashboardScreen extends GetView<NewDashboardScreenController> {
  bool validate = false;
  NewDashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: SizedBox(), label: ""),
          BottomNavigationBarItem(icon: SizedBox(), label: ""),
        ],
      ),
      appBar: DeliveryAppBar(
        appBar: AppBar(),
      ),
      backgroundColor: AppColors.newBg,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 2,
                  width: double.maxFinite,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SafeArea(
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // color: Colors.green,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text("DASHBOARD",
                                            style: CustomTextStyle.mainTitle
                                                .copyWith(
                                                    color: Color(0xff454E52))),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              // color: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                // vertical: 10,
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.toNamed(Routes.newStore);
                                                },
                                                child: Material(
                                                  elevation: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DashboardItemBox(
                                                      title: "Store",
                                                      icon:
                                                          "assets/svg/store.svg"),
                                                ),
                                              ),
                                              // SizedBox(o
                                              //   width: 2,
                                              // ),
                                              InkWell(
                                                onTap: () => Get.toNamed(
                                                    Routes.newFinancial),
                                                child: Material(
                                                  elevation: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DashboardItemBox(
                                                      title: "Financial",
                                                      icon:
                                                          "assets/svg/bank.svg"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Material(
                                                elevation: 5,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: DashboardItemBox(
                                                    title: "Stock",
                                                    icon:
                                                        "assets/svg/truck.svg"),
                                              ),
                                              // SizedBox(
                                              //   width: 2,
                                              // ),
                                              InkWell(
                                                onTap: () => Get.toNamed(
                                                    Routes.newSalesList),
                                                child: Material(
                                                  elevation: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DashboardItemBox(
                                                      title: "Sales List",
                                                      icon:
                                                          "assets/svg/sales-list.svg"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () => Get.toNamed(
                                                    Routes.newQuotations),
                                                child: Material(
                                                  elevation: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DashboardItemBox(
                                                      title: "Quotations",
                                                      icon:
                                                          "assets/svg/quatations.svg"),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 2,
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Material(
                              elevation: 5,
                              child: Container(
                                width: double.maxFinite,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8.0),
                                    topLeft: Radius.circular(8.0),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, top: 50),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
