import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/controllers/new_sales_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/sale_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_category_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/components/static/app_logo.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class NewSalesScreen extends GetView<NewSalesScreenController> {
  bool validate = false;
  NewSalesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // controller.init();
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
      floatingActionButton: InkWell(
        onTap: () => Get.toNamed(Routes.newBasket,
            arguments: {"addedProducts": controller.addedProducts}),
        child: SizedBox(
          height: 60,
          width: 60,
          child: Stack(
            children: [
              const FittedBox(
                child: FloatingActionButton(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: AppColors.newPrimary,
                  ),
                  backgroundColor: AppColors.newSecondary,
                  onPressed: null,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10, bottom: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.newRed,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Obx(() {
                    return Text(
                      controller.addedProducts.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              )
            ],
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
                        child: Text("SALES",
                            style: CustomTextStyle.mainTitle
                                .copyWith(color: const Color(0xff454E52))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  flex: 15,
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
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 50),
                      child: SingleChildScrollView(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                        width: double.maxFinite,
                                        child: TextFieldDelivery(
                                          controller: controller.searchCtrl,
                                          hint: "Search",
                                          icon: Icons.search_outlined,
                                        )),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap:(){
                                          Get.defaultDialog( //   title: "",
                                            title: "Scan Product Code",
                                            content: SizedBox(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height:40.h,
                                                      child: MobileScanner(
                                                          allowDuplicates: false,
                                                          onDetect: (barcode, args) {
                                                            if (barcode.rawValue == null) {
                                                              debugPrint('Failed to scan Barcode');
                                                              // controller.test();
                                                            } else {
                                                              final String code = barcode.rawValue!.toString();
                                                              Get.back();
                                                              controller.addProductViaScan(code);
                                                            }
                                                          })),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: Get.back,
                                                    child: Text('OK'),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: AppColors.deliveryPrimary80,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(12), // <-- Radius
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/barcode.svg",
                                          height: 22,
                                          width: 22,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      // width: 85,
                                      decoration: BoxDecoration(
                                          color: AppColors.deliveryPrimary,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      child: const Center(
                                          child: Text(
                                        "Category",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      // width: 85,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff1BCED8),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      child: const Center(
                                          child: Text(
                                        "Sub Category",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      // width: 85,
                                      decoration: BoxDecoration(
                                          color: AppColors.newRed,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      child: const Center(
                                          child: Text(
                                        "Brand",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() {
                              return Container(
                                child: controller.filteredProducts.isNotEmpty
                                    ? Wrap(
                                        spacing: 10,
                                        runSpacing: 20,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  controller
                                                      .filteredProducts.length;
                                              i++) ...[
                                            SaleItem(
                                              product: controller
                                                  .filteredProducts[i],
                                              index: i,
                                              addToBasket:
                                                  controller.addToBasket,
                                            ),
                                          ],
                                        ],
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
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
