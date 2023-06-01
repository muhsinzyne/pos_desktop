// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posdelivery/app/modules/pos-delivery/products-for-orders/controllers/delivery_products_for_orders_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/product.dart';

class DeliveryProductsForOrdersScreen
    extends GetView<DeliveryProductsForOrdersScreenController> {
  DeliveryProductsForOrdersScreen({Key? key}) : super(key: key);
  final List<String> _dropdownValues1 = [
    "Category",
    "Two",
    "Three",
    "Four",
    "Five"
  ];
  final List<String> _dropdownValues2 = [
    "Brand",
    "Two",
    "Three",
    "Four",
    "Five"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select",
                                    style: CustomTextStyle.mainTitle,
                                  ),
                                  Text(
                                    "Products",
                                    style: CustomTextStyle.mainTitle,
                                  )
                                ],
                              ),
                              Container(
                                child: Image.asset(
                                  "assets/images/qrscan.png",
                                  height: 100,
                                  width: 100,
                                  color: AppColors.deliverySecondary,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              DropdownDelivey(dropdownValues: _dropdownValues1),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownDelivey(dropdownValues: _dropdownValues2)
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFieldDelivery(
                            controller: controller.searchCtrl,
                            hint: "Search Product Name/code",
                            icon: Icons.search_outlined,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Obx(() {
                            return Container(
                              height: Constants.screenHeight * 0.5,
                              width: Constants.screenWidth,
                              child: controller.filteredProducts.isNotEmpty
                                  ? Container(
                                      child:
                                          ListView(shrinkWrap: true, children: [
                                        Wrap(
                                          runSpacing: 10,
                                          spacing: 10,
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    controller.filteredProducts
                                                        .length;
                                                i++) ...[
                                              InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                      Routes
                                                          .deliveryAddProductsOrder,
                                                      arguments: {
                                                        "code": controller
                                                            .filteredProducts[i]
                                                            .row!
                                                            .code
                                                      });
                                                },
                                                child: Container(
                                                  width: Constants.screenWidth *
                                                      0.25,
                                                  child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      color: AppColors
                                                          .deliveryPrimaryLight,
                                                      child: Center(
                                                        child: Text(controller
                                                            .filteredProducts[i]
                                                            .label
                                                            .toString()),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ]),
                                    )
                                  : const Text(
                                      'No Prouducts',
                                      style: TextStyle(fontSize: 24),
                                    ),
                            );
                          }),
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
