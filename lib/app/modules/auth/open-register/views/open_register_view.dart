import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/components/buttons/bottom_sheet_btn.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';

import '../../../../ui/components/buttons/bottom_sheet_btn_content.dart';
import '../controllers/open_register_controller.dart';

class OpenRegisterView extends GetView<OpenRegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('open_register'.tr),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: Column(
          children: [
            TextField(
              controller: controller.cashInHand,
              obscureText: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'cash_in_hand'.tr,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheetBtnBlock(
        children: [
          CBottomSheetBtn(
            color: Colors.green,
            label: 'open_register'.tr,
            onTap: () {
              controller.actionOpenRegister();
            },
            //onTap: controller.actionToPosPage,
          )
        ],
      ),
    );
  }
}
