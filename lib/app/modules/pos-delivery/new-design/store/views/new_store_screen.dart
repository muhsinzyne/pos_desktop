import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_category_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class NewStoreScreen extends GetView<NewStoreScreenController> {
  bool validate = false;
  NewStoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.newSecondary,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SvgPicture.asset(
                "assets/svg/menu.svg",
                height: 30,
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
      floatingActionButton: InkWell(
        onTap: () => Get.toNamed(Routes.newQr),
        child: SizedBox(
          height: 60,
          width: 60,
          child: FittedBox(
            child: FloatingActionButton(
              child: SvgPicture.asset(
                "assets/svg/qr.svg",
                fit: BoxFit.fitHeight,
              ),
              backgroundColor: AppColors.newSecondary,
              onPressed: null,
            ),
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
                      child: Text("STORE",
                          style: CustomTextStyle.mainTitle
                              .copyWith(color: const Color(0xff454E52))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Get.toNamed(Routes.newAddStore),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 10),
                    child: SvgPicture.asset(
                      "assets/svg/store-add.svg",
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: Material(
                  elevation: 5,
                  child: Container(
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
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: double.maxFinite,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.newBg,
                              ),
                              child: TextFieldDelivery(
                                controller: controller.searchCtrl,
                                hint: "Search",
                                icon: Icons.search_outlined,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 40,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: StoreCategoryItem(
                                      text: "Restaurant",
                                      icon: Icons.restaurant,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: StoreCategoryItem(
                                      text: "Retail",
                                      icon: Icons.storefront,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: StoreCategoryItem(
                                      text: "Coffee shop",
                                      icon: Icons.coffee,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return Column(
                              children: [
                                for (int i = 0;
                                    i < controller.filteredcustomerList.length;
                                    i++) ...[
                                  InkWell(
                                    child: StoreItem(
                                      name: controller
                                          .filteredcustomerList[i].name!,
                                    ),
                                    onTap: () {
                                      controller.selectedStore =
                                          controller.filteredcustomerList[i];
                                      Get.toNamed(Routes.newSales);
                                    },
                                  ),
                                ],
                              ],
                            );
                          }),
                        ],
                      ),
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
