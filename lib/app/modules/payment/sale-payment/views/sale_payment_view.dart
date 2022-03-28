import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/components/buttons/bottom_sheet_btn.dart';
import 'package:posdelivery/app/ui/components/buttons/bottom_sheet_btn_content.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';

import '../controllers/sale_payment_controller.dart';

class SalePaymentView extends GetView<SalePaymentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Obx(() {
          return Text('payment'.tr +
              ' ' +
              (controller.salePaymentNavParams.value.referenceNo ?? ''));
        }),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Container(
            padding: EdgeInsets.all(Constants.pagePadding),
            child: Column(
              children: [
                TextField(
                  enabled: controller.disabledFormFiled.value,
                  controller: controller.invoiceTotalAmount,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'invoice_total'.tr,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  enabled: controller.disabledFormFiled.value,
                  controller: controller.dueAmount,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'due_amount'.tr,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  enabled: controller.disabledFormFiled.value,
                  controller: controller.balanceAmount,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'balance_amount'.tr,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  enabled: controller.disabledFormFiled.value,
                  controller: controller.changeAmount,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'change'.tr,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.paymentAmount,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    controller.onChangedPaymentAmount();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'payment_amount'.tr,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      bottomSheet: BottomSheetBtnBlock(
        children: [
          CBottomSheetBtn(
            color: Colors.green,
            label: 'confirm'.tr,
            onTap: () {
              controller.actionConfirmOrder(context);
            },
            //onTap: controller.actionToPosPage,
          )
        ],
      ),
    );
  }
}
