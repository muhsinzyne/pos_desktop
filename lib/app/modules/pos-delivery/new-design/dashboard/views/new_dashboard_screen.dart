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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 30),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes.newAddStore);
                                                  },
                                                  child: Material(
                                                    elevation: 5,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: DashboardItemBox(
                                                        title: "Store",
                                                        icon:
                                                            "assets/svg/store.svg"),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   width: 2,
                                                // ),
                                                Material(
                                                  elevation: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DashboardItemBox(
                                                      title: "Financial",
                                                      icon:
                                                          "assets/svg/bank.svg"),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                Material(
                                                  elevation: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DashboardItemBox(
                                                      title: "Sales List",
                                                      icon:
                                                          "assets/svg/sales-list.svg"),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Material(
                                                  elevation: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DashboardItemBox(
                                                      title: "Quotations",
                                                      icon:
                                                          "assets/svg/quatations.svg"),
                                                ),
                                                // SizedBox(
                                                //   width: 2,
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          // height: 100,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8.0),
                                              topLeft: Radius.circular(8.0),
                                            ),
                                          ),
                                          child: AspectRatio(
                                            aspectRatio: 1.1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(8.0),
                                                  topLeft: Radius.circular(8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
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
        ],
      ),
    );
  }
}
