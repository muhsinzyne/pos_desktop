import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/components/buttons/bottom_sheet_btn.dart';
import 'package:posdelivery/app/ui/components/buttons/bottom_sheet_btn_content.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/requests/pos/product_purchase_info.dart';

import '../controllers/pos_bill_screen_controller.dart';

class PosBillView extends GetView<PosBillScreenController> {
  int backPress = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backPress++;
        if (backPress > 1) {
          controller.clearBasket();
          return true;
        } else {
          controller.onBackPressNotify();
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgLight,
        appBar: AppBar(
          title: Text('add_sale'.tr + ' ' + ''),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(Constants.pagePadding10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.pagePadding10,
                            vertical: Constants.pagePadding10),
                        color: AppColors.secondary,
                        child: Text(
                          'order_items'.tr,
                          style: kBaseTextStyle.copyWith(
                            fontSize: 16,
                            color: AppColors.bgLight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Material(
                        color: AppColors.primaryVariant,
                        child: InkWell(
                          onTap: () {
                            controller.actionSearch(context);
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                'add_product'.tr,
                                style: kBaseTextStyle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.all(10),
                        child: Material(
                          color: AppColors.primary,
                          child: InkWell(
                            onTap: () async {
                              // product
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.qr_code_scanner_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount:
                          controller.appService.productPurchaseList.length,
                      itemBuilder: (BuildContext context, int i) {
                        ProductPurchaseInfo cInfo =
                            controller.appService.productPurchaseList[i];
                        return Slidable(
                          actionExtentRatio: .3,
                          secondaryActions: [
                            IconSlideAction(
                              caption: 'edit'.tr,
                              color: Colors.blue,
                              icon: Icons.edit,
                              onTap: () {
                                controller.actionOnEditRequest(cInfo);
                              },
                              closeOnTap: true,
                            ),
                            IconSlideAction(
                              caption: 'delete'.tr,
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                controller.actionOnRemoveItemList(cInfo);
                              },
                              closeOnTap: true,
                            ),
                          ],
                          actionPane: SlidableDrawerActionPane(),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                ProductTileItem(
                                  label: cInfo.itemName,
                                  value: cInfo.totalAmount.toStringAsFixed(2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                ProductTileItem(
                                  label: 'net_unit_price'.tr,
                                  value: cInfo.unitPrice.toStringAsFixed(2),
                                  fontSize: 14,
                                ),
                                ProductTileItem(
                                  label: 'quantity'.tr,
                                  value: cInfo.itemQty.toString(),
                                  fontSize: 14,
                                ),
                                ProductTileItem(
                                  label: 'total_tax'.tr,
                                  value: cInfo.totalTax.toStringAsFixed(2),
                                  fontSize: 14,
                                ),
                                ProductTileItem(
                                  label: 'sub_total'.tr,
                                  value: cInfo.subTotal.toStringAsFixed(2),
                                  fontSize: 16,
                                ),
                                ProductTileItem(
                                  label: 'grand_total'.tr,
                                  value: cInfo.totalAmount.toStringAsFixed(2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  valueFontSize: 20,
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        );
                      });
                }),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
        bottomSheet: BottomSheetBtnBlock(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'grand_total'.tr,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Obx(() {
                              return AutoSizeText(
                                controller.appService.grandTotalAmount,
                                minFontSize: 20,
                                maxFontSize: 22,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CBottomSheetBtn(
              color: AppColors.primaryVariant,
              label: 'proceed'.tr,
              onTap: () {
                controller.actionToPayment();
              },
              //onTap: controller.actionToPosPage,
            )
          ],
        ),
      ),
    );
  }
}

class ProductTileItem extends StatelessWidget {
  const ProductTileItem({
    Key? key,
    this.label,
    this.value,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 12,
    this.valueFontSize = 16,
  }) : super(key: key);

  final String? label;
  final String? value;
  final FontWeight fontWeight;
  final double fontSize;
  final double valueFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label ?? '',
          style: kBaseTextStyle.copyWith(
              fontWeight: fontWeight, fontSize: fontSize),
        ),
        Text(
          value ?? '',
          style: kBaseTextStyle.copyWith(
            fontWeight: fontWeight,
            fontSize: valueFontSize,
          ),
        ),
      ],
    );
  }
}
