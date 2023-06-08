// ignore_for_file: prefer_const_constructors

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/add-store/controllers/new_add_store_controller.dart';
import 'package:logger/logger.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

import 'package:posdelivery/app/modules/pos-delivery/new-design/profile/controllers/new_profile_controller.dart';

class NewProfileScreen extends GetView<NewProfileScreenController> {
  bool validate = false;

  NewProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      backgroundColor: AppColors.newBg,
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 40.h,
                  child: Stack(children: [
                    Container(
                      height: (40.h) - 60,
                      color: AppColors.deliveryPrimary,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 6.h,
                          ),
                          InkWell(
                            onTap:Get.back,
                            child: Row(

                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(width: 5,),
                                  Center(child: Text("Profile",style: TextStyle(fontSize:20,color: Colors.white,fontWeight: FontWeight.bold),))
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 60,
                            ),
                          ],
                        ))
                  ])),
              Expanded(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Text(controller.name.value);
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Divider(thickness: 2),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Text(controller.email.value);
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Divider(thickness: 2),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Text(controller.number.value);
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Divider(thickness: 2),
                  ),
                ],
              ))
            ]),
      ),
    );
  }
}
