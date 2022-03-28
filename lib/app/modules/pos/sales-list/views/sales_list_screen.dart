import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/components/loading/skelton_loading.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/models/response/pos/sales_list.dart';

import '../controllers/sales_list_screen_controller.dart';

class SalesListScreen extends GetView<SalesListScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        title: Text('sales_list'.tr),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
          controller: controller.scrollCtrl,
          itemCount: controller.isLoading.isTrue
              ? controller.salesList.length + 1
              : controller.salesList.length,
          itemBuilder: (BuildContext context, int i) {
            if (i == controller.salesList.length) {
              return LoadingUI.renderSkeleton(3);
            }
            SalesInfoShort cSales = controller.salesList[i];
            print(cSales.toJson());
            return Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Card(
                child: InkWell(
                  onTap: () {
                    controller.actionOnInvoiceView(cSales);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    cSales.customer!,
                                    textAlign: TextAlign.start,
                                    style: kBaseTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        cSales.date!,
                                        textAlign: TextAlign.end,
                                        style: kBaseTextStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        cSales.referenceNo!,
                                        textAlign: TextAlign.end,
                                        style: kBaseTextStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                color: Colors.green,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                child: Text(
                                  cSales.saleStatus!,
                                  style: kBaseTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                color: Colors.green,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                child: Text(
                                  cSales.paymentStatus!,
                                  style: kBaseTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'total'.tr,
                                                  style:
                                                      kBaseTextStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.secondary,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  controller.sr.formatCurrency(
                                                      double.tryParse(
                                                          cSales.grandTotal!)!),
                                                  style:
                                                      kBaseTextStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.secondary,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'balannce'.tr,
                                                  style:
                                                      kBaseTextStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  controller.sr.formatCurrency(
                                                      double.tryParse(
                                                          cSales.balance ??
                                                              '0.0')!),
                                                  //controller.sr.formatCurrency(double.tryParse(cSales.balance)),
                                                  style:
                                                      kBaseTextStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    controller.openFile(cSales);
                                                  },
                                                  icon: Icon(
                                                    FontAwesomeIcons.print,
                                                    color: AppColors
                                                        .primaryVariant,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                // TextButton(
                                                //   onPressed: () {},
                                                //   child: Text('add_payment'.tr),
                                                // ),
                                                IconButton(
                                                  onPressed: () {
                                                    controller
                                                        .actionOnAddPayment(
                                                            cSales);
                                                  },
                                                  icon: Icon(
                                                    FontAwesomeIcons.dollarSign,
                                                    color: AppColors
                                                        .primaryVariant,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Expanded(
                                        //   child: Container(
                                        //     child: Column(
                                        //       crossAxisAlignment: CrossAxisAlignment.end,
                                        //       children: [
                                        //         PopupMenuButton(
                                        //           icon: Icon(
                                        //             Icons.more_vert,
                                        //           ),
                                        //           itemBuilder: (context) => [
                                        //             PopupMenuItem(
                                        //               child: Row(
                                        //                 children: [
                                        //                   Icon(
                                        //                     FontAwesomeIcons.print,
                                        //                     color: AppColors.primaryVariant,
                                        //                   ),
                                        //                   SizedBox(
                                        //                     width: 5,
                                        //                   ),
                                        //                   Text('print_pos_invoice'.tr),
                                        //                 ],
                                        //               ),
                                        //               value: 1,
                                        //             ),
                                        //             PopupMenuItem(
                                        //               child: Row(
                                        //                 children: [
                                        //                   Icon(
                                        //                     FontAwesomeIcons.print,
                                        //                     color: AppColors.primaryVariant,
                                        //                   ),
                                        //                   SizedBox(
                                        //                     width: 5,
                                        //                   ),
                                        //                   Text('print_b2b_invoice'.tr),
                                        //                 ],
                                        //               ),
                                        //               value: 1,
                                        //               onTap: () {},
                                        //             ),
                                        //             PopupMenuItem(
                                        //               child: Row(
                                        //                 children: [
                                        //                   Icon(
                                        //                     FontAwesomeIcons.cashRegister,
                                        //                     color: AppColors.primaryVariant,
                                        //                   ),
                                        //                   SizedBox(
                                        //                     width: 5,
                                        //                   ),
                                        //                   Text('add_payments'.tr),
                                        //                 ],
                                        //               ),
                                        //               value: 1,
                                        //               onTap: () {},
                                        //             ),
                                        //             PopupMenuItem(
                                        //               child: Row(
                                        //                 children: [
                                        //                   Icon(
                                        //                     Icons.undo,
                                        //                     color: AppColors.primaryVariant,
                                        //                   ),
                                        //                   SizedBox(
                                        //                     width: 5,
                                        //                   ),
                                        //                   Text('return_sales'.tr),
                                        //                 ],
                                        //               ),
                                        //               value: 1,
                                        //               onTap: () {},
                                        //             )
                                        //           ],
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
