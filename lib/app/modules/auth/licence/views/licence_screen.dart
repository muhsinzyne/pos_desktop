import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/components/static/app_logo.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/controllers/app_controller.dart';
import 'package:posdelivery/models/constants.dart';

import '../controllers/licence_screen_controller.dart';

class LicenceScreen extends GetView<LicenceScreenController> {
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    height: Get.height * .8,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Hero(
                              tag: Constants.logoHeroTag,
                              child: AppLogo(
                                inverse: true,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: Get.size.width * .05,
                  child: AutoSizeText(
                    'validate_licence'.tr,
                    style: kBaseTextStyle.copyWith(fontSize: 26, color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * .2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                            child: TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(Constants.licenceCodeLength),
                              ],
                              obscureText: false,
                              //keyboardType: TextInputType.numberWithOptions(),
                              onChanged: (String number) {
                                controller.licenceCode.value = number;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'licence_code'.tr,
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(child: child, scale: animation);
                            },
                            child: controller.isLoading.value == false ? getTapButtonBlock(context) : getLoadingWidget(),
                          );
                        }),
                      ],
                    ),
                  ),
                  //getFooterMobileUI(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLoadingWidget() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(),
    );
  }

  Widget getTapButtonBlock(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(
          Radius.circular(38.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.withOpacity(0.4), offset: Offset(0, 2), blurRadius: 8.0),
        ],
      ),
      child: Material(
        color: controller.continuePermission.value == true ? AppColors.primary : Colors.grey.shade500,
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
          onTap: controller.continuePermission.value == true
              ? () {
                  appController.appClearKeyboardFocus(context);
                  controller.actionLicenceValidate();
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              FontAwesomeIcons.arrowRight,
              size: 20,
              color: AppColors.bgLight,
            ),
          ),
        ),
      ),
    );
  }
}
