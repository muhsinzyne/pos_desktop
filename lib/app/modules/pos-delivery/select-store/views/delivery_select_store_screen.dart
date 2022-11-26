// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/select-store/controllers/delivery_select_store_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class DeliveryAddStoreScreen
    extends GetView<DeliverySelectStoreScreenController> {
  final List<String> _dropdownValues = [
    "Select Manually",
    "Two",
    "Three",
    "Four",
    "Five"
  ];

  // In order to get hot reload to work we need to pause the camera if the platform
  // // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: const Text(
                                "Store",
                                style: CustomTextStyle.mainTitle,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 20),
                              decoration: BoxDecoration(
                                color: AppColors.deliveryPrimary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.deliveryAddStore);
                                },
                                child: Text(
                                  "Add Store",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Column(children: [
                          Obx(() {
                            return Container(
                                height: Constants.screenHeight * 0.25,
                                width: Constants.screenWidth * 0.7,
                                child: controller.isQrOpen.value
                                    ? MobileScanner(
                                        allowDuplicates: false,
                                        onDetect: (barcode, args) {
                                          if (barcode.rawValue == null) {
                                            debugPrint(
                                                'Failed to scan Barcode');
                                            // controller.test();
                                          } else {
                                            final String code =
                                                barcode.rawValue!;
                                            debugPrint('Barcode found! $code');
                                            controller.scanQR(code);
                                          }
                                        })
                                    : Image.asset(
                                        "assets/images/qrscan.png",
                                        height: Constants.screenHeight / 4,
                                        width: Constants.screenWidth / 2,
                                        color: AppColors.deliverySecondary,
                                      ));
                          }),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              controller.toggleCamera();
                            },
                            child: Container(
                              width: Constants.screenWidth * 0.4,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.deliveryPrimary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "SCAN",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                    Text(
                      "Available Stores",
                      style: CustomTextStyle.mainTitle.copyWith(fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Obx(() {
                      return Container(
                        height: Constants.screenHeight * 0.3,
                        width: Constants.screenWidth,
                        child: controller.warehouseList.isNotEmpty
                            ? Container(
                                child: ListView(shrinkWrap: true, children: [
                                  Wrap(
                                    runSpacing: 10,
                                    spacing: 10,
                                    children: [
                                      for (int i = 0;
                                          i < controller.warehouseList.length;
                                          i++) ...[
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                Routes.deliveryStoreDetails,
                                                arguments: {
                                                  "code": controller
                                                      .warehouseList[i].id
                                                });
                                          },
                                          child: Container(
                                            width: Constants.screenWidth * 0.25,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                color: Color(0xffF9F6EE),
                                                child: Center(
                                                  child: Text(controller
                                                      .warehouseList[i].name
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
            ),
          ],
        ),
      ),
    );
    ;
  }
}
