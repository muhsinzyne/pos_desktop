import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/lock/controllers/new_lock_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/quotations/controllers/new_quotations_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_category_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/components/static/app_logo.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

class NewLockScreen extends GetView<NewLockScreenController> {
  bool validate = false;
  NewLockScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.newPrimary,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: AppLogo(
                          inverse: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: ScreenLock(
                        title: Text("Forget your password?"),
                        cancelButton: Icon(
                          Icons.backspace_outlined,
                          color: Colors.white,
                        ),
                        correctString: '12345',
                        customizedButtonTap: () {},
                        customizedButtonChild:
                            SvgPicture.asset("assets/svg/face.svg"),
                        useBlur: false,
                        config: ScreenLockConfig(
                          titleTextStyle: TextStyle(fontSize: 10.sp),
                          backgroundColor: AppColors.newPrimary,
                        ),
                        onUnlocked: () {},
                        keyPadConfig: KeyPadConfig(
                            actionButtonConfig: KeyPadButtonConfig(
                                buttonStyle: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white),
                            buttonConfig: KeyPadButtonConfig(
                                buttonStyle: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                backgroundColor: AppColors.newPrimary,
                                foregroundColor: Colors.white)),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset("assets/images/fatoorah-small.png"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
