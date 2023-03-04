// ignore_for_file: prefer_const_constructors

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/add-store/controllers/new_add_store_controller.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/dashboard/controllers/new_dashboard_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/financial/controllers/new_financial_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dashboard_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class NewFinancialScreen extends GetView<NewFinancialScreenController> {
  bool validate = false;
  NewFinancialScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.newSecondary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SvgPicture.asset(
                "assets/svg/menu.svg",
                height: 30,
                width: 30,
                color: AppColors.newIconColor,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(icon: SizedBox(), label: ""),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/back.svg",
              height: 30,
              color: AppColors.newIconColor,
              width: 30,
            ),
            label: 'Back',
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            child: Container(),
            //  Icon(
            //   Icons.shopping_cart_outlined,
            //   size: 30,
            //   color: AppColors.newPrimary,
            // ),
            //  SvgPicture.asset(
            //   "assets/svg/cart.svg",
            //   fit: BoxFit.fitHeight,
            // ),
            backgroundColor: AppColors.newSecondary,
            onPressed: null,
          ),
        ),
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
                            flex: 5,
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
                                                  Get.toNamed(
                                                      Routes.newAddStore);
                                                },
                                                child: Material(
                                                  elevation: 5,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: DashboardItemBox(
                                                      title:
                                                          "Completed Payment",
                                                      icon:
                                                          "assets/svg/bank-tick.svg"),
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
                                                    title: "Pending Payment",
                                                    icon:
                                                        "assets/svg/bank-no.svg"),
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
                                                    title: "Add Payment",
                                                    icon:
                                                        "assets/svg/bank-plus.svg"),
                                              ),
                                              // SizedBox(
                                              //   width: 2,
                                              // ),
                                              Material(
                                                elevation: 5,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: DashboardItemBox(
                                                    title: "Payment History",
                                                    icon:
                                                        "assets/svg/bank-histonry.svg"),
                                              ),
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
                            flex: 6,
                            child: Material(
                              elevation: 5,
                              child: SizedBox(
                                height: Constants.screenHeight * 0.3,
                                child: SingleChildScrollView(
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
                                    child: Wrap(
                                      spacing: 7,
                                      runSpacing: 10,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FinancialItem(
                                          text: "Cash in Hand",
                                          color: AppColors.newPrimary,
                                        ),
                                        FinancialItem(
                                          text: "Sales Value",
                                          color: Colors.green,
                                        ),
                                        FinancialItem(
                                            text: "Stock Value",
                                            color: AppColors.newPrimary),
                                        FinancialItem(
                                            text: "Return Value",
                                            color: Colors.red),
                                        FinancialItem(
                                            text: "Due Payment",
                                            color: AppColors.newPrimary),
                                        FinancialItem(
                                            text: "Stores Served",
                                            color: AppColors.newBlue),
                                      ],
                                    ),
                                  ),
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

class FinancialItem extends StatelessWidget {
  final Color color;
  final String text;
  const FinancialItem({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: Constants.screenWidth * 0.4,
      decoration: BoxDecoration(
          color: AppColors.newBg, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "SAR",
                  style: CustomTextStyle.mainTitle.copyWith(
                      fontSize: 15,
                      color: AppColors.newPrimary,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              "2523.22",
              style: CustomTextStyle.mainTitle
                  .copyWith(fontSize: 17, color: AppColors.newPrimary),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            // height: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Center(
                child: Container(
                    padding: const EdgeInsets.all(14),
                    child: Text(text,
                        style: CustomTextStyle.mainTitle
                            .copyWith(fontSize: 15, color: Colors.white)))),
          )
        ],
      ),
    );
  }
}
