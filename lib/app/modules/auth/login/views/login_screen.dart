import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/auth/login/views/login_bg.dart';
import 'package:posdelivery/app/ui/components/buttons/rounded_btn.dart';
import 'package:posdelivery/app/ui/components/input_style_1.dart';
import 'package:posdelivery/app/ui/components/static/app_logo.dart';
import 'package:posdelivery/app/ui/components/static/app_version_row.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/controllers/app_controller.dart';
import 'package:posdelivery/models/constants.dart';

import '../controllers/login_screen_controller.dart';

class LoginScreen extends GetView<LoginScreenController> {
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return BackgroundLogin(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //appBar: buildAppBar(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColors.primary,
          ),
          actions: [
            TextButton(
              onPressed: appController.toggleLanguage,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Text(
                  'lang'.tr,
                  style: kBaseTextStyle.copyWith(fontFamily: fontFamilyReverse),
                ),
              ),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            appController.appClearKeyboardFocus(context);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(Constants.pagePadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 2,
                            child: AppLogo(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: AutoSizeText(
                                'lets_get_started'.tr,
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
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        //color: Colors.red,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Form(
                                      key: controller.loginFormKey,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                              margin: EdgeInsets.only(top: 20),
                                              decoration: BoxDecoration(
                                                  //color: AppColors.bgLight,
                                                  ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    'login_title'.tr,
                                                    textAlign: TextAlign.center,
                                                    style: kBaseTextStyle.copyWith(fontFamily: fontFamily, fontSize: 26),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  UserInputStyle1(
                                                    icon: FontAwesomeIcons.userAlt,
                                                    inputCtl: controller.usernameInput,
                                                    onFieldSubmitted: (String value) {
                                                      controller.nextFocus(controller.passwordFocus, context);
                                                    },
                                                    focusNode: controller.usernameFocus,
                                                    keyboardType: TextInputType.text,
                                                    labelKey: 'login_username',
                                                    textInputAction: TextInputAction.next,
                                                    secondColor: AppColors.primary,
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  //usernameInputField(context),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Obx(
                                                    () {
                                                      return UserInputStyle1(
                                                        isPassword: true,
                                                        hidePassword: controller.hidePassword.isTrue,
                                                        icon: FontAwesomeIcons.lock,
                                                        inputCtl: controller.passwordInput,
                                                        onFieldSubmitted: (String value) {
                                                          controller.submitForm();
                                                        },
                                                        focusNode: controller.passwordFocus,
                                                        keyboardType: TextInputType.text,
                                                        labelKey: 'login_password',
                                                        textInputAction: TextInputAction.done,
                                                        secondColor: AppColors.primary,
                                                        passwordToggle: () {
                                                          controller.hidePassword.toggle();
                                                          //controller.hidePassword = !controller.hidePassword;
                                                          print(controller.hidePassword);
                                                        },
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return 'Please enter some text';
                                                          }
                                                          return null;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Obx(
                                                    () {
                                                      return CheckboxListTile(
                                                        title: Text(
                                                          'login_remember_me'.tr,
                                                          textAlign: TextAlign.start,
                                                        ),
                                                        controlAffinity: ListTileControlAffinity.leading,
                                                        value: controller.isRememberMeInput.isTrue,
                                                        onChanged: (value) {
                                                          controller.isRememberMeInput.toggle();
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  CRoundedButton(
                                                    width: Get.size.width,
                                                    textColor: AppColors.bgLight,
                                                    onPress: controller.submitForm,
                                                    text: 'login_btn'.tr,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
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
    );
  }
}
