import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/basket/controllers/new_basket_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/controllers/new_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/basket_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/sale_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_category_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/components/static/app_logo.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class NewBasketScreen extends GetView<NewBasketScreenController> {
  bool validate = false;
  NewBasketScreen({Key? key}) : super(key: key);
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
                color: AppColors.newIconColor,
                width: 30,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(icon: SizedBox(), label: ""),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                "assets/svg/back.svg",
                height: 30,
                width: 30,
              ),
            ),
            label: '',
          ),
        ],
      ),
      floatingActionButton: const SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
              color: AppColors.newPrimary,
            ),
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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("BASKET",
                          style: CustomTextStyle.mainTitle
                              .copyWith(color: const Color(0xff454E52))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 15,
                child: Material(
                  elevation: 5,
                  child: Container(
                    width: double.maxFinite,
                    // height: Constants.screenHeight * 0.7,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 15),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: (Constants.screenHeight * 0.4) + 35,
                          child: Obx(() {
                            return ListView(
                              children: [
                                for (int i = 0;
                                    i < controller.cartProducts.length;
                                    i++) ...[
                                  BasketItem(
                                    label: controller
                                        .cartProducts[i].cartItem!.label!,
                                    increment: controller.increment,
                                    dicrement: controller.discrment,
                                    price: controller
                                        .cartProducts[i].cartItem!.row!.price
                                        .toString(),
                                    remove: controller.removeItem,
                                    index: i,
                                    qty: controller.cartProducts[i].quantity!,
                                  )
                                ]
                              ],
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 236, 236),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 185, 183, 183))),
                          width: double.maxFinite,
                          height: Constants.screenHeight * 0.18,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Biller Name",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.newIconColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    // alignment: Alignment.centerLeft,
                                    // height: 30,
                                    // width: 85,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xff1BCED8)),
                                        borderRadius: BorderRadius.circular(7)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 2),
                                    child: Obx(() {
                                      return Text(
                                        controller.biller.value,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 4, right: 10),
                                    child: const Text(
                                      "Total",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        // alignment: Alignment.centerLeft,
                                        // height: 30,
                                        // width: 85,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppColors.newPrimary),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Obx(() {
                                          return Text(
                                            "${controller.total} SAR",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          );
                                        }),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: controller.completeSale,
                                        child: Container(
                                          // alignment: Alignment.centerLeft,
                                          // height: 30,
                                          // width: 85,
                                          decoration: BoxDecoration(
                                              color: AppColors.newPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: const Text(
                                            "Complete Sale",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
