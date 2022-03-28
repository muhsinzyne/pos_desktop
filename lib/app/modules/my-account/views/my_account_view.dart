import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/components/profile/profile_info_card_block.dart';
import 'package:posdelivery/app/ui/components/static/employee_name_row.dart';
import 'package:posdelivery/app/ui/components/static/theme_text_underline.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/services/app_service.dart';

import '../controllers/my_account_controller.dart';

class MyAccountView extends GetView<MyAccountController> {
  final AppService appService = Get.find<AppService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('my_account'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Constants.pagePadding5),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ProfileInfoCardBlock(),
              EmployeeNameRow(appService: appService),
              Container(
                margin: EdgeInsets.all(2),
                height: 100,
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.pagePadding10,
                    vertical: Constants.pagePadding10),
                child: Column(
                  children: [
                    UserInfoIconItem(
                      icon: Icons.phone_android_outlined,
                      color: AppColors.textBlue,
                      labelText: 'mobile'.tr,
                      value: '963309223',
                      fontSize: 12,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UserInfoIconItem(
                      icon: Icons.phone,
                      color: AppColors.textBlue,
                      labelText: 'extension'.tr,
                      value: '610',
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(2),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.pagePadding10,
                    vertical: Constants.pagePadding10),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          AutoSizeText(
                            'my_details'.tr,
                            style: kBaseTextStyle.copyWith(
                              fontSize: 20,
                              color: AppColors.textBlue,
                            ),
                          ),
                          ThemeTextUnderLine(
                            width: 60,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          ExpandablePanel(
                            header: AutoSizeText(
                              'attendance'.tr,
                              style: kBaseTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackOpa,
                                fontFamily: fontFamily,
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Icon(FontAwesomeIcons
                                                        .solidClock),
                                                    Container(
                                                      child: Obx(
                                                        () {
                                                          return AutoSizeText(
                                                            controller
                                                                .cDateString
                                                                .value,
                                                            style:
                                                                kBaseTextStyle
                                                                    .copyWith(
                                                              color: AppColors
                                                                  .blackOpa,
                                                              fontSize: 14,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      //color: Colors.black,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                    ),
                                                  ],
                                                ),
                                                //color: Color(0xffddf1cb),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: Color(0xffddf1cb),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: TextButton(
                                                  onPressed: () {
                                                    Get.bottomSheet(Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Container(
                                                              color:
                                                                  Colors.white,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        controller
                                                                            .cancelDateChange,
                                                                    child: Text(
                                                                        'cancel'
                                                                            .tr),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        controller
                                                                            .updateSearchDate,
                                                                    child: Text(
                                                                        'done'
                                                                            .tr),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child:
                                                                  CupertinoDatePicker(
                                                                mode:
                                                                    CupertinoDatePickerMode
                                                                        .date,
                                                                initialDateTime:
                                                                    DateTime
                                                                        .now(),
                                                                onDateTimeChanged:
                                                                    (DateTime
                                                                        newDateTime) {
                                                                  controller
                                                                          .cChangeDate =
                                                                      newDateTime;
                                                                },
                                                              ),
                                                              height: 200,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ));
                                                  },
                                                  child: Container(
                                                    child:
                                                        Text('change_date'.tr),
                                                  ),
                                                ),
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    // child: CupertinoExtended.CupertinoDatePicker(
                                    //   mode: CupertinoExtended.CupertinoDatePickerMode.date,
                                    //   initialDateTime: DateTime.now(),
                                    //   onDateTimeChanged: (DateTime newDateTime) {
                                    //     print(newDateTime.month);
                                    //     // Do something
                                    //   },
                                    // ),
                                  ),
                                  Container(
                                      child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: 100,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(stops: [
                                            0.02,
                                            0.02
                                          ], colors: [
                                            AppColors.primary,
                                            Colors.white
                                          ]),
                                          borderRadius: BorderRadius.all(
                                            const Radius.circular(6.0),
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'لايوجد بصمة',
                                                style: kBaseTextStyle.copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  fontFamily: english,
                                                ),
                                              ),
                                              Text(
                                                '24',
                                                style: kBaseTextStyle.copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: english,
                                                ),
                                              ),
                                            ],
                                          ),
                                          title: Text('Day_Name, 10.30 : 4:30'),
                                          subtitle: Text('Sample Notes'),
                                          trailing: Text(
                                            '14:35',
                                          ),
                                          onTap: () {
                                            //controller.changeLanguage(cLanguage);
                                          },
                                        ),
                                      );
                                    },
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoIconItem extends StatelessWidget {
  const UserInfoIconItem({
    Key? key,
    this.icon = Icons.info,
    this.color = AppColors.primary,
    this.labelText = '',
    this.value = '',
    this.fontSize = 12.0,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String labelText;
  final String value;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.ideographic,
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          labelText,
          style: kBaseTextStyle.copyWith(
            color: AppColors.textBlue,
            fontSize: fontSize,
          ),
        ),
        Text(
          ':',
          style: kBaseTextStyle.copyWith(
            color: AppColors.textBlue,
            fontSize: fontSize,
          ),
        ),
        Text(
          value,
          style: kBaseTextStyle.copyWith(
            color: AppColors.textBlue,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
