import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:posdelivery/app/modules/pos/print-view/controllers/print_screen_controller.dart';
import 'package:posdelivery/app/ui/components/buttons/bottom_sheet_btn.dart';
import 'package:posdelivery/app/ui/components/loading/cached_image_network.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/static/tax_summary.dart';

import '../../../../../models/response/pos/product_row.dart';
import '../../../../../models/response/pos/return_rows.dart';
import '../../../../ui/components/static/item_summary_title.dart';

class PrintScreen extends GetView<PrintScreenController> {
  List<TableRow> _generateTableItemList() {
    List<TableRow> rowItems = [];
    rowItems.add(TableRow(
      children: [
        Column(
          children: [
            Text(
              'name'.tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'qty'.tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'tax_excl'.tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'tax_amount'.tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ));
    List<TaxSummaryList> taxSummaryList = [];
    for (ProductRows element in controller.invoiceResponse.value.rows) {
      if (element.taxName != Constants.none || element.taxCode != null) {
        var taxIndex =
            taxSummaryList.indexWhere((tax) => tax.id == element.taxRateId);
        if (taxIndex == Constants.unDefinedIndex) {
          TaxSummaryList newTaxList = TaxSummaryList();
          newTaxList.id = element.taxRateId;
          newTaxList.name = element.taxName;
          newTaxList.qty = double.tryParse(element.quantity!)!;
          newTaxList.taxEx = double.tryParse(element.netUnitPrice!)!;
          newTaxList.taxAmt = double.tryParse(element.itemTax!)!;
          taxSummaryList.add(newTaxList);
        } else {
          TaxSummaryList newTaxList = taxSummaryList[taxIndex];
          newTaxList.qty = newTaxList.qty + double.tryParse(element.quantity!)!;
          newTaxList.taxEx =
              newTaxList.taxEx + double.tryParse(element.netUnitPrice!)!;
          newTaxList.taxAmt =
              newTaxList.taxAmt + double.tryParse(element.itemTax!)!;
          taxSummaryList[taxIndex] = newTaxList;
        }
      }
    }

    for (var taxItem in taxSummaryList) {
      rowItems.add(TableRow(
        children: [
          Column(
            children: [
              Text(taxItem.name ?? ''),
            ],
          ),
          Column(
            children: [
              Text((taxItem.qty).toStringAsFixed(1)),
            ],
          ),
          Column(
            children: [
              Text((taxItem.taxEx).toStringAsFixed(2)),
            ],
          ),
          Column(
            children: [
              Text((taxItem.taxAmt).toStringAsFixed(2)),
            ],
          ),
        ],
      ));
    }

    return rowItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('print_invoice'.tr),
        centerTitle: true,
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => controller.printProvider.refreshBluetoothScan(),
          child: SingleChildScrollView(
            //physics: ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.pagePadding,
                              vertical: Constants.pagePadding5),
                          color: controller.printProvider.connected.value
                              ? Colors.green
                              : Colors.red,
                          child: Text(
                            controller.printProvider.conMsg.value,
                            style: kBaseTextStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'device'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Container(
                              child: DropdownButton<dynamic>(
                                value: controller.printProvider.device,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                onChanged: (value) {
                                  controller.printProvider.device = value;
                                  controller.printProvider.connect();
                                },
                                items: controller.printProvider.allList
                                    .map<DropdownMenuItem<BluetoothDevice>>(
                                        (value) {
                                  return DropdownMenuItem<BluetoothDevice>(
                                    value: value,
                                    child: Text(value.name!),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Obx(
                              () {
                                return CCachedNetworkImage(
                                  imageUrl: (controller
                                              .invoiceResponse.value.domain ??
                                          '') +
                                      '/assets/uploads/' +
                                      (controller.invoiceResponse.value
                                              .userDirectory ??
                                          '') +
                                      '/logos/' +
                                      (controller.invoiceResponse.value.biller!
                                              .logo ??
                                          ''),
                                  fit: BoxFit.contain,
                                  width: 300,
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Obx(() {
                              return Text(
                                controller.invoiceResponse.value.biller?.name ??
                                    '',
                                style: TextStyle(fontSize: 22),
                              );
                            }),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return AutoSizeText(
                                controller.invoiceResponse.value.biller
                                        ?.address ??
                                    '',
                                maxLines: 2,
                                style: TextStyle(fontSize: 16),
                              );
                            }),
                            Obx(() {
                              return AutoSizeText(
                                'tel'.tr +
                                    (controller.invoiceResponse.value.biller
                                            ?.phone ??
                                        ''),
                                maxLines: 2,
                                style: TextStyle(fontSize: 18),
                              );
                            }),
                            Obx(() {
                              return AutoSizeText(
                                'vat'.tr +
                                    (controller.invoiceResponse.value.biller
                                            ?.vatNo ??
                                        ''),
                                maxLines: 2,
                                style: TextStyle(fontSize: 18),
                              );
                            }),
                            SizedBox(
                              height: 10,
                            ),
                            controller.invoiceResponse.value.inv?.saleStatus ==
                                    SalesStatus.returned
                                ? AutoSizeText(
                                    'return_invoice'.tr.toUpperCase(),
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : AutoSizeText(
                                    'tax_invoice'.tr.toUpperCase(),
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Obx(() {
                                  return Text(
                                    'date'.tr +
                                        ': ' +
                                        (controller.invoiceResponse.value.inv
                                                ?.date ??
                                            ''),
                                    textAlign: TextAlign.start,
                                  );
                                }),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'sl_no'.tr +
                                      ': ' +
                                      (controller.invoiceResponse.value.inv
                                              ?.referenceNo ??
                                          ''),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Obx(() {
                                  return Text(
                                    'sales_associate'.tr +
                                        ': ' +
                                        ((controller.invoiceResponse.value
                                                    .createdBy?.firstName ??
                                                '') +
                                            ' ' +
                                            (controller.invoiceResponse.value
                                                    .createdBy?.lastName ??
                                                '')),
                                    textAlign: TextAlign.start,
                                  );
                                }),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Obx(() {
                                  return Text(
                                    'customer'.tr +
                                        ': ' +
                                        (controller.invoiceResponse.value
                                                .customer?.name ??
                                            ''),
                                    textAlign: TextAlign.start,
                                  );
                                }),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('items'.tr.toUpperCase()),
                            Divider(),
                            ItemsListTile(
                              number: '#',
                              itemName: 'item_name'.tr,
                              qty: 'qty'.tr,
                              unitPrice: 'upc'.tr,
                              taxAmount: 'tax_amt'.tr,
                              subTotal: 'sub_total'.tr,
                            ),
                            Obx(() {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: controller
                                    .invoiceResponse.value.rows.length,
                                itemBuilder: (BuildContext context, int i) {
                                  final ProductRows saleProduct =
                                      controller.invoiceResponse.value.rows[i];
                                  var serialNo = (i + 1).toString();
                                  return ItemsListTile(
                                    number: serialNo,
                                    itemName: saleProduct.productName!,
                                    qty: double.tryParse(saleProduct.quantity!)!
                                        .toStringAsFixed(1),
                                    unitPrice:
                                        double.tryParse(saleProduct.unitPrice!)!
                                            .toStringAsFixed(2),
                                    taxAmount:
                                        double.tryParse(saleProduct.itemTax!)!
                                            .toStringAsFixed(2),
                                    subTotal: ((double.tryParse(
                                                saleProduct.subtotal!)!) +
                                            (double.tryParse(
                                                saleProduct.itemTax!)!))
                                        .toStringAsFixed(2),
                                  );
                                },
                              );
                            }),
                            Divider(),
                            Text('returned_items'.tr.toUpperCase()),
                            Divider(),
                            ItemsListTile(
                              number: '#',
                              itemName: 'item_name'.tr,
                              qty: 'qty'.tr,
                              unitPrice: 'upc'.tr,
                              taxAmount: 'tax_amt'.tr,
                              subTotal: 'sub_total'.tr,
                            ),
                            Obx(() {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: controller.invoiceResponse.value
                                        .returnRows?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int i) {
                                  final ReturnRows returnItem = controller
                                      .invoiceResponse.value.returnRows![i];
                                  var serialNo = (i + 1).toString();
                                  return ItemsListTile(
                                    number: serialNo,
                                    itemName: returnItem.productName!,
                                    qty: double.tryParse(returnItem.quantity!)!
                                        .toStringAsFixed(1),
                                    unitPrice:
                                        double.tryParse(returnItem.unitPrice!)!
                                            .toStringAsFixed(2),
                                    taxAmount:
                                        double.tryParse(returnItem.itemTax!)!
                                            .toStringAsFixed(2),
                                    subTotal: ((double.tryParse(
                                                returnItem.subtotal!)!) +
                                            (double.tryParse(
                                                returnItem.itemTax!)!))
                                        .toStringAsFixed(2),
                                  );
                                },
                              );
                            }),
                            ItemSummaryTile(
                              label: 'total'.tr,
                              value: controller.invoiceResponse.value.total
                                  .toStringAsFixed(2),
                            ),
                            ItemSummaryTile(
                              label: 'vat'.tr,
                              value: controller.invoiceResponse.value.totalTax
                                  .toStringAsFixed(2),
                            ),
                            ItemSummaryTile(
                              label: 'grand_total'.tr,
                              value: controller.invoiceResponse.value.grandTotal
                                  .toStringAsFixed(2),
                            ),
                            ItemSummaryTile(
                              label: 'paid'.tr,
                              value: controller.invoiceResponse.value.totalPaid
                                  .toStringAsFixed(2),
                            ),
                            controller.invoiceResponse.value.balanceAmount > 0.0
                                ? ItemSummaryTile(
                                    label: 'balance'.tr,
                                    value: controller
                                        .invoiceResponse.value.balanceAmount
                                        .toStringAsFixed(2),
                                  )
                                : Container(),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text('paid_by'.tr + ': ' + 'cash'.tr),
                            //     Text('amount'.tr + ': ' + controller.invoiceResponse.value.payments[0]),
                            //     Text('Change: 0.0'),
                            //   ],
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'tax_summary'.tr,
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            Table(
                              border: TableBorder.all(),
                              children: _generateTableItemList(),
                            ),
                            controller.isLoading.isFalse
                                ? Obx(
                                    () {
                                      return Image.memory(
                                        base64Decode(controller.invoiceResponse
                                            .value.qrCodeImageWithOutMeta),
                                      );
                                    },
                                  )
                                : Container(),
                            SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.refresh,
            ),
            label: 'refresh_bluetooth'.tr,
            onTap: () {
              controller.printProvider.refreshBluetoothScan();
              print("blutooth refresh");
            },
          ),
          SpeedDialChild(
            child: Icon(
              Icons.bluetooth_disabled,
            ),
            label: 'disconnect'.tr,
            onTap: () {
              controller.printProvider.disconnect();
              print("blutooth refresh");
            },
          ),
          SpeedDialChild(
            child: Icon(
              Icons.bluetooth,
            ),
            label: 'connect'.tr,
            onTap: () {
              controller.printProvider.connect();
              //print("blutooth refresh");
            },
          )
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        height: Get.height * .08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CBottomSheetBtn(
              color: AppColors.primaryVariant,
              icon: Icons.print,
              label: 'print'.tr,
              onTap: () {
                controller.actionOnPrint();
              },
            ),
            CBottomSheetBtn(
              color: AppColors.primary,
              icon: Icons.share,
              label: 'share_invoice'.tr,
              onTap: () {
                controller.openInvoice(controller.invoiceResponse.value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
