// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:posdelivery/app/modules/pos-delivery/sales-payment/controllers/delivery_sales_payment_controller.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';

import '../../../../../models/constants.dart';

class DeliverySalesPaymentScreen
    extends GetView<DeliverySalesPaymentScreenController> {
  const DeliverySalesPaymentScreen({Key? key}) : super(key: key);

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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sale Payment",
                                    style: CustomTextStyle.mainTitle,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 43,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sales Total"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(
                                controller: controller.dueAmount,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Payment Amount"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(
                                controller: controller.paymentAmount,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Balance"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(
                                controller: controller.balanceAmount,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Change"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(
                                controller: controller.changeAmount,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Obx(() {
                            return Container(
                              child: controller.isDue.value
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Due Date"),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFieldDelivery(
                                          controller: controller.dueDate,
                                        ),
                                      ],
                                    )
                                  : Container(),
                            );
                          })
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.actionConfirmOrder(context);
                      },
                      child: Container(
                        height: 85,
                        width: double.infinity,
                        color: AppColors.deliveryPrimary,
                        child: Center(
                            child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        )),
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
