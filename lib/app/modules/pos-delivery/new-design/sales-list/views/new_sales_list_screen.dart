import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales-list/controllers/new_sales_list_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_list_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class NewSalesListScreen extends GetView<NewSalesListScreenController> {
  bool validate = false;
  NewSalesListScreen({Key? key}) : super(key: key);
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
                color: AppColors.newIconColor,
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
        // onTap: () => controller.fetc,
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
                      child: Text("SALES LIST",
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.newBg,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Search",
                                    style: TextStyle(
                                        color: Color(0xff8D9EA4), fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Color(0xff8D9EA4),
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Obx(() {
                            return Column(
                              children: [
                                for (int i = 0;
                                    i < controller.filteredSalesList.length;
                                    i++) ...[
                                  InkWell(
                                    child: SalesListItem(
                                      downloadPdf: controller.fetchInvoice,
                                      statusColor: controller
                                                  .filteredSalesList[i]
                                                  .saleStatus! ==
                                              'completed'
                                          ? Colors.green
                                          : Colors.red,
                                      refNo: controller
                                          .filteredSalesList[i].referenceNo!,
                                      amount:
                                          controller.filteredSalesList[i].paid!,
                                      date:
                                          controller.filteredSalesList[i].date!,
                                      saleStatus: controller
                                          .filteredSalesList[i].saleStatus!,
                                      storeName: controller
                                          .filteredSalesList[i].customer!,
                                      balance: controller
                                          .filteredSalesList[i].balance!,
                                      paid:
                                          controller.filteredSalesList[i].paid!,
                                      grandTotal: controller
                                          .filteredSalesList[i].grandTotal!,
                                      id: controller.filteredSalesList[i].id!,
                                      paymentStatus: controller
                                          .filteredSalesList[i].paymentStatus!,
                                    ),
                                    // StoreItem(
                                    //   name: controller
                                    //       .filteredcustomerList[i].name!,
                                    // ),
                                    onTap: () {
                                      // controller.selectedStore =
                                      //     controller.filteredcustomerList[i];
                                      // Get.toNamed(Routes.newSales);
                                    },
                                  ),
                                ],
                              ],
                            );
                          }),
                          // Column(
                          //   children: [
                          //     SalesListItem(
                          //       statusColor: Colors.green,
                          //     ),
                          //     SalesListItem(
                          //       statusColor: Colors.red,
                          //     ),
                          //     SizedBox(
                          //       height: 10,
                          //     ),
                          //   ],
                          // ),
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
