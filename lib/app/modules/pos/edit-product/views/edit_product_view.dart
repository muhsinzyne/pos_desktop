import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos/add-product/views/add_product_view.dart';
import 'package:posdelivery/app/ui/components/buttons/bottom_sheet_btn.dart';
import 'package:posdelivery/app/ui/components/buttons/bottom_sheet_btn_content.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/units.dart';

import '../controllers/edit_product_controller.dart';

class EditProductView extends GetView<EditProductController> {
  List<DropdownMenuItem<String>> generateUnitItems() {
    final List<DropdownMenuItem<String>> unitList = [];
    for (var element in controller.units) {
      Units cUnit = element;
      unitList.add(
        DropdownMenuItem<String>(
          value: cUnit.id,
          child: Container(
            width: 100,
            child: Text(
              cUnit.name.toString(),
            ),
          ),
        ),
      );
    }
    return unitList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          backgroundColor: AppColors.bgLight,
          appBar: AppBar(
            title: Text('edit_product'.tr),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(Constants.pagePadding10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.productName,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'product'.tr,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: TextField(
                            controller: controller.productQty,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'quantity'.tr + ' *',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              controller.actionOnChangeQty();
                            },
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 5,
                        child: Container(
                          //height: 100,
                          //color: Colors.red,
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: DropdownButton<String>(
                                    hint: Container(
                                      width: Get.size.width * .3,
                                      height: 100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'unit'.tr + ' *',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Obx(() {
                                            return Text(
                                                controller.cUnitName.value);
                                          }),
                                        ],
                                      ),
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    onChanged: (String? newValue) {
                                      controller.actionOnChangeUnit(newValue!);
                                    },
                                    items: generateUnitItems(),
                                  ),
                                  height: 75,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        child: TextField(
                          controller: controller.rate,
                          obscureText: false,
                          onChanged: (value) {
                            controller.onChangeRate();
                          },
                          decoration: InputDecoration(
                            labelText: 'rate'.tr +
                                '(' +
                                'price'.tr +
                                '/' +
                                'unit'.tr +
                                ') *',
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: AppColors.primary,
                          height: 200,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Center(
                              child: Text(
                                'total'.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 12,
                        child: Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProductSummaryInfo(
                                label: 'sub_total'.tr +
                                    '(' +
                                    'rate'.tr +
                                    'x' +
                                    'qty'.tr +
                                    ')',
                                value: controller.infoSubTotal.value,
                              ),
                              ProductSummaryInfo(
                                label: 'discount'.tr,
                                value: controller.infoItemDiscount.value,
                              ),
                              ProductSummaryInfo(
                                label: 'tax'.tr + '(' + 'excl'.tr + ')',
                                value: controller.infoTaxRate.value,
                              ),
                              ProductSummaryInfo(
                                label: 'tax_amount'.tr,
                                value: controller.totalTax.value,
                              ),
                              ProductSummaryInfo(
                                label: 'total_amount'.tr,
                                value: controller.infoTotalAmount.value,
                              ),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: BottomSheetBtnBlock(
            children: [
              CBottomSheetBtn(
                color: Colors.red,
                label: 'delete'.tr,
                onTap: () {
                  controller.actionOnRemoveItemList();
                },
                //onTap: controller.actionToPosPage,
              ),
              CBottomSheetBtn(
                color: AppColors.primaryVariant,
                label: 'update'.tr,
                onTap: () {
                  controller.actionUpdate(context);
                },
                //onTap: controller.actionToPosPage,
              )
            ],
          )),
    );
  }
}
