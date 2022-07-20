// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DeliveryAddStoreScreen extends StatefulWidget {
  DeliveryAddStoreScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAddStoreScreen> createState() => _DeliveryAddStoreScreenState();
}

class _DeliveryAddStoreScreenState extends State<DeliveryAddStoreScreen> {
  final List<String> _dropdownValues = [
    "Select Manually",
    "Two",
    "Three",
    "Four",
    "Five"
  ];

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  bool isQrOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                          decoration: BoxDecoration(
                            color: AppColors.deliveryPrimary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "Add Store",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Constants.screenHeight / 9,
                    ),
                    Column(children: [
                      Container(
                          height: Constants.screenHeight / 3,
                          width: Constants.screenWidth * 0.8,
                          child: isQrOpen
                              ? QRView(
                                  key: qrKey,
                                  onQRViewCreated: _onQRViewCreated,
                                )
                              : Image.asset(
                                  "assets/images/qrscan.png",
                                  height: Constants.screenHeight / 4,
                                  width: Constants.screenWidth / 2,
                                  color: AppColors.deliverySecondary,
                                )),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isQrOpen = !isQrOpen;
                          });
                        },
                        child: Container(
                          width: Constants.screenWidth / 2,
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
                      height: Constants.screenHeight / 5,
                    ),
                    DropdownDelivey(dropdownValues: _dropdownValues),
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
