import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:posdelivery/app/modules/auth/otp_verification/views/otp_bg.dart';
import 'package:posdelivery/app/ui/components/static/app_version_row.dart';
import 'package:posdelivery/app/ui/components/static/chamber_row_logo.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/controllers/app_controller.dart';
import 'package:posdelivery/models/constants.dart';

import '../controllers/otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return BackgroundOtp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColors.primary,
          ),
        ),
        body: GestureDetector(
          onTap: () {
            appController.appClearKeyboardFocus(context);
          },
          child: SingleChildScrollView(
            child: Container(
              height: (Get.size.height - Constants.commonSafeAreaTop),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(Constants.pagePadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ChamberRowLogo(),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: AutoSizeText(
                                  'verify_your_otp'.tr,
                                  style: kBaseTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondaryVariant,
                                    fontSize: 28,
                                    //fontFamily: fontFamily,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 100),
                                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                                child: PinCodeTextField(
                                  appContext: context,
                                  onChanged: (String value) {
                                    controller.otpValue = value;
                                  },
                                  length: Constants.otpLength,
                                  animationType: AnimationType.fade,
                                  errorAnimationController: controller.otpErrorController,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.underline,
                                    activeColor: AppColors.primary,
                                    inactiveColor: Colors.grey,
                                    activeFillColor: Colors.green,
                                    selectedFillColor: AppColors.secondary,
                                    inactiveFillColor: AppColors.primaryVariant,
                                  ),
                                  animationDuration: Duration(milliseconds: 300),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppVersionRow(appController: appController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
