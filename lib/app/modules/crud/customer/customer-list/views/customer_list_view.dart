import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/components/buttons/custom_elevated_button.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/models/response/customer/customer_data.dart';

import '../controllers/customer_list_controller.dart';

class CustomerListView extends GetView<CustomerListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('customer_list'.tr),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.lightBg,
        child: Obx(() {
          return ListView.builder(
            itemCount: controller.customerList.length,
            itemBuilder: (BuildContext context, int i) {
              final CustomerData cCustomerData = controller.customerList[i];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Card(
                  child: InkWell(
                    onTap: () {
                      //controller.actionOnInvoiceView(cSales);
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
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cCustomerData.company!,
                                          textAlign: TextAlign.start,
                                          style: kBaseTextStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          cCustomerData.name!,
                                          textAlign: TextAlign.start,
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
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'vat_no'.tr +
                                              ': ' +
                                              cCustomerData.vatNo!,
                                          style: kBaseTextStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        cCustomerData.isDue
                                            ? Container(
                                                color: Colors.red,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 3),
                                                child: Text(
                                                  'over_due'.tr,
                                                  style:
                                                      kBaseTextStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              )
                                            : cCustomerData.isOverPaid
                                                ? Container(
                                                    color: Colors.green,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 3),
                                                    child: Text(
                                                      'deposit'.tr,
                                                      style: kBaseTextStyle
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                        cCustomerData.isOverPaid
                                            ? Text(
                                                cCustomerData.dueAccount
                                                    .toStringAsFixed(2),
                                                style: kBaseTextStyle.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  fontSize: 22,
                                                ),
                                              )
                                            : Text(
                                                cCustomerData.dueAccount
                                                    .toStringAsFixed(2),
                                                style: kBaseTextStyle.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: cCustomerData.isDue
                                                      ? Colors.red
                                                      : AppColors.secondary,
                                                  fontSize: 22,
                                                ),
                                              ),
                                      ],
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
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cCustomerData.email!,
                                          style: kBaseTextStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          cCustomerData.phone!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: CElevatedButton(
                                      onPress: () {
                                        controller
                                            .actionOnSalesList(cCustomerData);
                                      },
                                      label: 'sales'.tr,
                                      fontSize: 16,
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
      ),
    );
  }
}
