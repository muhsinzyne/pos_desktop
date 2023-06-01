// ignore_for_file: prefer_const_constructors

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/qr-scanning/controllers/new_qr_controller.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class NewQRScreen extends GetView<NewQRScreenController> {
  bool validate = false;
  NewQRScreen({Key? key}) : super(key: key);
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
          BottomNavigationBarItem(icon: SizedBox(), label: ""),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/back.svg",
              color: AppColors.newIconColor,
              height: 30,
              width: 30,
            ),
            label: 'Back',
          ),
        ],
      ),
      floatingActionButton: SizedBox(
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
      appBar: DeliveryAppBar(
        appBar: AppBar(),
      ),
      backgroundColor: AppColors.newBg,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
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
                              child: Text("QR/Barcode Scanning",
                                  style: CustomTextStyle.mainTitle.copyWith(
                                      color: const Color(0xff454E52))),
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
                          elevation: 3,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 40),
                            child: SizedBox(
                                height: 100,
                                child: MobileScanner(
                                    allowDuplicates: false,
                                    onDetect: (barcode, args) {
                                      if (barcode.rawValue == null) {
                                        debugPrint('Failed to scan Barcode');
                                        // controller.test();
                                      } else {
                                        final String code = barcode.rawValue!;
                                        controller.logger.e(barcode.format);
                                        controller.logger.e(code);
                                        // controller.scanQR(code);
                                      }
                                    })),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
