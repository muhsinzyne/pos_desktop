// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import '../controllers/delivery_add_expenses_controller.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryAddExpensesScreen
    extends GetView<DeliveryAddExpensesScreenController> {
  bool validate = false;
  DeliveryAddExpensesScreen({Key? key}) : super(key: key);
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: const Text("Add Expenses",
                                    style: CustomTextStyle.mainTitle),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Amount"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(
                                controller: controller.amount,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Reference"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(
                                controller: controller.reference,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Cateogory"),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                    color: Color(0x99E5E5E5),
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: AppColors.deliverySecondary,
                                        width: 0,
                                        style: BorderStyle.solid)),
                                child: DropdownButtonFormField<CategoryOption>(
                                  decoration: InputDecoration(
                                      hintText: "Select category",
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                  onChanged: (value) {
                                    controller.category = value!.key.toString();
                                  },
                                  items:
                                      controller.categories.map((selectedType) {
                                    return DropdownMenuItem<CategoryOption>(
                                      child: Text(
                                        selectedType.fullName,
                                      ),
                                      value: selectedType,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  child: Text("Attachment"),
                                  onTap: controller.addAttachments,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Obx(() {
                                  return Row(children: [
                                    if (controller.isFile.value) ...[
                                      Text(
                                          controller.file!.filename.toString()),
                                      IconButton(
                                          onPressed:
                                              controller.removeAttachments,
                                          icon: Icon(Icons.close))
                                    ] else
                                      ...[],
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(15),
                                          backgroundColor: Color(0x99E5E5E5),
                                          primary: Colors.grey[700],
                                        ),
                                        onPressed: controller.addAttachments,
                                        child: Text("Browse..")),
                                  ]);
                                })
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Notes"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(
                                controller: controller.note,
                                maxLine: 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.vaidate();
                      },
                      child: Container(
                        height: 85,
                        width: double.infinity,
                        color: AppColors.deliveryPrimary,
                        child: Center(
                            child: Text(
                          "test",
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
