import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/complete-sale/controllers/new_complete_sale_controller.dart';
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
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class NewCompleteSaleScreen extends GetView<NewCompleteSaleScreenController> {
  bool validate = false;
  NewCompleteSaleScreen({Key? key}) : super(key: key);
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
                      child: Text("COMPLETE SALE",
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
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                  ),
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
                        const EdgeInsets.only(right: 10, left: 10, top: 50),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 236, 236),
                            ),
                            width: double.maxFinite,
                            height: Constants.screenHeight * 0.18,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Obx(() {
                              return controller.isLoaded.value
                                  ? PDFView(
                                      filePath: controller.pdfPath.value,
                                      // enableSwipe: true,
                                      // swipeHorizontal: true,
                                      autoSpacing: false,
                                      onRender: (_pages) {
                                        Logger().w("redner");
                                        // setState(() {
                                        //   pages = _pages;
                                        //   isReady = true;
                                        // });
                                      },
                                      onError: (error) {
                                        Logger().wtf(error);
                                        print(error.toString());
                                      },
                                      onPageError: (page, error) {
                                        Logger().e(error);
                                        // print('$page: ${error.toString()}');
                                      },
                                      onViewCreated: (PDFViewController
                                          pdfViewController) {
                                        Logger().w("pdf");
                                        controller.pdfController
                                            .complete(pdfViewController);
                                      },
                                      // onPageChanged: (int page, int total) {
                                      //   // print('page change: $page/$total');
                                      // },
                                    )
                                  : const Center(
                                      child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator()),
                                    );
                            }),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.newPrintInvoice,
                                      arguments:
                                          controller.invoiceResponse.value);
                                },
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: AppColors.deliveryPrimary,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: const Center(
                                      child: Text(
                                    "Print",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  //  controller.d
                                  if (controller.isLoaded.value) {
                                    Share.shareFiles([controller.pdfPath.value],
                                        text: 'Great picture');
                                  } else {
                                    Get.snackbar("File", "Loading");
                                  }
                                },
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Color(0xff129537),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Share  ",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        Icons.share_outlined,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Container(
                              //   height: 30,
                              //   decoration: BoxDecoration(
                              //       color: Color(0xff129537),
                              //       borderRadius: BorderRadius.circular(10)),
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 10, vertical: 5),
                              //   child: Row(
                              //     children: [
                              //       Text(
                              //         "Share  ",
                              //         style: TextStyle(
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //       Icon(
                              //         Icons.whatsapp,
                              //         size: 18,
                              //         color: Colors.white,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(),
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
