import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/dashboard/views/app_drawer.dart';
import 'package:posdelivery/app/ui/components/buttons/text_btn.dart';
import 'package:posdelivery/app/ui/components/profile/profile_info_card_block.dart';
import 'package:posdelivery/app/ui/components/static/theme_text_underline.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/controllers/app_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/services/app_service.dart';

import '../controllers/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardScreenController> {
  final AppController appController = Get.find<AppController>();
  final AppService appService = Get.find<AppService>();

  @override
  Widget build(BuildContext context) {
    //print(dashboardController.localStorage);
    return Scaffold(
      key: appController.appDrawerKey,
      appBar: AppBar(
        title: Text('dashboard_title'.tr),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Constants.pagePadding5),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return ProfileInfoCardBlock(
                  currentRegisterResponse: controller.cRegister.value,
                  registerCloseSummary: controller.registerCloseSummary.value,
                );
              }),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10, left: 3, right: 3),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.pagePadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              'POS'.tr,
                              style: kBaseTextStyle.copyWith(
                                fontSize: 20,
                                color: AppColors.textBlue,
                              ),
                            ),
                            ThemeTextUnderLine(
                              width: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CTextButton(
                                      text: 'sales'.tr,
                                      color: AppColors.primary,
                                      textColor: Colors.white,
                                      onPress: () {
                                        controller.actionGoSales();
                                      },
                                      width: Get.size.width / 2.5,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    CTextButton(
                                      text: 'returns'.tr,
                                      color: AppColors.secondary,
                                      textColor: Colors.white,
                                      onPress: () {
                                        controller.actionGoReturns();
                                      },
                                      width: Get.size.width / 2.5,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CTextButton(
                                      text: 'sales_history'.tr,
                                      color: AppColors.secondary,
                                      textColor: Colors.white,
                                      onPress: () {
                                        controller.actionGoSalesHistory();
                                      },
                                      width: Get.size.width / 2.5,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    CTextButton(
                                      text: 'payments'.tr,
                                      color: AppColors.greenIconColor,
                                      textColor: Colors.white,
                                      onPress: () {
                                        controller.actionGoPayments(context);
                                      },
                                      width: Get.size.width / 2.5,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CTextButton(
                                      text: 'customers'.tr,
                                      color: AppColors.greenIconColor,
                                      textColor: Colors.white,
                                      onPress: () {
                                        controller.actionOnCustomers();
                                      },
                                      width: Get.size.width / 2.5,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    CTextButton(
                                      text: 'POS'.tr,
                                      color: AppColors.greenIconColor,
                                      textColor: Colors.white,
                                      onPress: () {
                                        controller.actionPOSSalesWindow();
                                      },
                                      width: Get.size.width / 2.5,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     CTextButton(
                                //       text: 'hr_letter_request'.tr,
                                //       color: AppColors.primary,
                                //       textColor: Colors.white,
                                //       onPress: () {},
                                //       width: Get.size.width / 2.5,
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //     CTextButton(
                                //       text: 'evaluation'.tr,
                                //       color: AppColors.secondary,
                                //       textColor: Colors.white,
                                //       onPress: () {},
                                //       width: Get.size.width / 2.5,
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   color: Colors.white,
              //   margin: EdgeInsets.only(top: 15, left: 3, right: 3),
              //   padding: EdgeInsets.all(5),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //           padding: EdgeInsets.symmetric(horizontal: Constants.pagePadding),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               AutoSizeText(
              //                 'summary'.tr,
              //                 style: kBaseTextStyle.copyWith(
              //                   fontSize: 20,
              //                   color: AppColors.textBlue,
              //                 ),
              //               ),
              //               ThemeTextUnderLine(
              //                 width: 30,
              //               ),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Column(
              //                 children: [
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       CTextButton(
              //                         text: 'todays_report'.tr,
              //                         color: AppColors.secondary,
              //                         textColor: Colors.white,
              //                         onPress: () {},
              //                         width: Get.size.width / 2.5,
              //                         borderRadius: BorderRadius.circular(10),
              //                       ),
              //                       CTextButton(
              //                         text: 'this_week'.tr,
              //                         color: AppColors.greenIconColor,
              //                         textColor: Colors.white,
              //                         onPress: () {},
              //                         width: Get.size.width / 2.5,
              //                         borderRadius: BorderRadius.circular(10),
              //                       ),
              //                     ],
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       CTextButton(
              //                         text: 'this_year'.tr,
              //                         color: AppColors.secondary,
              //                         textColor: Colors.white,
              //                         onPress: () {},
              //                         width: Get.size.width / 2.5,
              //                         borderRadius: BorderRadius.circular(10),
              //                       ),
              //                       CTextButton(
              //                         text: 'print'.tr,
              //                         color: AppColors.secondary,
              //                         textColor: Colors.white,
              //                         onPress: () {
              //                           Get.toNamed(Routes.printView);
              //                         },
              //                         width: Get.size.width / 2.5,
              //                         borderRadius: BorderRadius.circular(10),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   color: Colors.white,
              //   margin: EdgeInsets.all(3),
              //   padding: EdgeInsets.all(5),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //           padding: EdgeInsets.symmetric(horizontal: Constants.pagePadding),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               AutoSizeText(
              //                 'admin_affairs'.tr,
              //                 style: kBaseTextStyle.copyWith(
              //                   fontSize: 20,
              //                   color: AppColors.textBlue,
              //                 ),
              //               ),
              //               ThemeTextUnderLine(
              //                 width: 60,
              //               ),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Column(
              //                 children: [
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       CTextButton(
              //                         text: 'maintenance_request'.tr,
              //                         color: AppColors.primary,
              //                         textColor: Colors.white,
              //                         onPress: () {},
              //                         width: Get.size.width / 2,
              //                         borderRadius: BorderRadius.circular(10),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //EmployeeNameRow(appService: appService),
            ],
          ),
        ),
      ),
    );
  }
}
