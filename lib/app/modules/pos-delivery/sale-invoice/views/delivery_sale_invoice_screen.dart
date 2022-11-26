// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:posdelivery/app/modules/pos-delivery/sale-invoice/controllers/delivery_sale_invoice_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/product_row.dart';

class DeliverySaleInvoiceScreen
    extends GetView<DeliverySaleInvoiceScreenController> {
  const DeliverySaleInvoiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(Routes.deliveryStoreDetails);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Invoice",
                                  style: CustomTextStyle.mainTitle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(() {
                                      return ElevatedButton(
                                        onPressed: controller
                                                        .blueThermalPrinterProdvider
                                                        .selectedPrinter
                                                        .value ==
                                                    null ||
                                                controller
                                                    .blueThermalPrinterProdvider
                                                    .isConnected
                                                    .value
                                            ? null
                                            : () {
                                                controller
                                                    .blueThermalPrinterProdvider
                                                    .connectDevice();
                                                // controller.connectDevice();
                                              },
                                        child: Text("Connect",
                                            textAlign: TextAlign.center),
                                      );
                                    }),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Obx(() {
                                      return ElevatedButton(
                                        onPressed: controller
                                                        .blueThermalPrinterProdvider
                                                        .selectedPrinter
                                                        .value ==
                                                    null ||
                                                !controller
                                                    .blueThermalPrinterProdvider
                                                    .isConnected
                                                    .value
                                            ? null
                                            : () {
                                                if (controller
                                                        .blueThermalPrinterProdvider
                                                        .selectedPrinter
                                                        .value !=
                                                    null) {
                                                  controller
                                                      .blueThermalPrinterProdvider
                                                      .printerManager
                                                      .disconnect(
                                                          type: controller
                                                              .blueThermalPrinterProdvider
                                                              .selectedPrinter
                                                              .value!
                                                              .typePrinter);
                                                }
                                                controller
                                                    .blueThermalPrinterProdvider
                                                    .isConnected
                                                    .value = false;
                                              },
                                        child: const Text("Disconnect",
                                            textAlign: TextAlign.center),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            DropdownButtonFormField<PrinterType>(
                              value: controller.blueThermalPrinterProdvider
                                  .defaultPrinterType,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.print,
                                  size: 24,
                                ),
                                labelText: "Type Printer Device",
                                labelStyle: TextStyle(fontSize: 18.0),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              items: <DropdownMenuItem<PrinterType>>[
                                if (Platform.isAndroid || Platform.isIOS)
                                  const DropdownMenuItem(
                                    value: PrinterType.bluetooth,
                                    child: Text("bluetooth"),
                                  ),
                                if (Platform.isAndroid || Platform.isWindows)
                                  const DropdownMenuItem(
                                    value: PrinterType.usb,
                                    child: Text("usb"),
                                  ),
                                const DropdownMenuItem(
                                  value: PrinterType.network,
                                  child: Text("Wifi"),
                                ),
                              ],
                              onChanged: (PrinterType? value) {
                                if (value != null) {
                                  controller.blueThermalPrinterProdvider
                                      .defaultPrinterType = value;
                                  controller.blueThermalPrinterProdvider
                                      .selectedPrinter.value = null;
                                  controller.blueThermalPrinterProdvider.isBle
                                      .value = false;
                                  controller.blueThermalPrinterProdvider
                                      .isConnected.value = false;
                                  controller.blueThermalPrinterProdvider.scan();
                                }
                              },
                            ),
                            Visibility(
                              visible: controller.blueThermalPrinterProdvider
                                          .defaultPrinterType ==
                                      PrinterType.bluetooth &&
                                  Platform.isAndroid,
                              child: SwitchListTile.adaptive(
                                contentPadding: const EdgeInsets.only(
                                    bottom: 20.0, left: 20),
                                title: const Text(
                                  "This device supports ble (low energy)",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 19.0),
                                ),
                                value: controller
                                    .blueThermalPrinterProdvider.isBle.value,
                                onChanged: (bool? value) {
                                  controller.blueThermalPrinterProdvider.isBle
                                      .value = value ?? false;
                                  controller.blueThermalPrinterProdvider
                                      .isConnected.value = false;
                                  controller.blueThermalPrinterProdvider
                                      .selectedPrinter.value = null;
                                  controller.blueThermalPrinterProdvider.scan();
                                },
                              ),
                            ),
                            Visibility(
                              visible: controller.blueThermalPrinterProdvider
                                          .defaultPrinterType ==
                                      PrinterType.bluetooth &&
                                  Platform.isAndroid,
                              child: SwitchListTile.adaptive(
                                contentPadding: const EdgeInsets.only(
                                    bottom: 20.0, left: 20),
                                title: const Text(
                                  "reconnect",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 19.0),
                                ),
                                value: controller.blueThermalPrinterProdvider
                                    .reconnect.value,
                                onChanged: (bool? value) {
                                  controller.blueThermalPrinterProdvider
                                      .reconnect.value = value ?? false;
                                },
                              ),
                            ),
                            Obx(() {
                              return Column(
                                  children: controller
                                      .blueThermalPrinterProdvider.devices
                                      .map(
                                        (device) => ListTile(
                                          title: Text('${device.deviceName}'),
                                          subtitle: Platform.isAndroid &&
                                                  controller
                                                          .blueThermalPrinterProdvider
                                                          .defaultPrinterType ==
                                                      PrinterType.usb
                                              ? null
                                              : Visibility(
                                                  visible: !Platform.isWindows,
                                                  child: Text(
                                                      "${device.address}")),
                                          onTap: () {
                                            // do something
                                            controller
                                                .blueThermalPrinterProdvider
                                                .selectDevice(device);
                                            controller
                                                .blueThermalPrinterProdvider
                                                .update();
                                          },
                                          leading: controller
                                                          .blueThermalPrinterProdvider
                                                          .selectedPrinter
                                                          .value !=
                                                      null &&
                                                  ((device.typePrinter == PrinterType.usb &&
                                                              Platform.isWindows
                                                          ? device.deviceName ==
                                                              controller
                                                                  .blueThermalPrinterProdvider
                                                                  .selectedPrinter
                                                                  .value!
                                                                  .deviceName
                                                          : device.vendorId != null &&
                                                              controller
                                                                      .blueThermalPrinterProdvider
                                                                      .selectedPrinter
                                                                      .value!
                                                                      .vendorId ==
                                                                  device
                                                                      .vendorId) ||
                                                      (device.address != null &&
                                                          controller
                                                                  .blueThermalPrinterProdvider
                                                                  .selectedPrinter
                                                                  .value!
                                                                  .address ==
                                                              device.address))
                                              ? const Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                )
                                              : null,
                                        ),
                                      )
                                      .toList());
                            }),
                            Visibility(
                              visible: controller.blueThermalPrinterProdvider
                                          .defaultPrinterType ==
                                      PrinterType.network &&
                                  Platform.isWindows,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: TextFormField(
                                  controller: controller
                                      .blueThermalPrinterProdvider.ipController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true),
                                  decoration: const InputDecoration(
                                    label: Text("Ip Address"),
                                    prefixIcon: Icon(Icons.wifi, size: 24),
                                  ),
                                  onChanged: controller
                                      .blueThermalPrinterProdvider.setIpAddress,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.blueThermalPrinterProdvider
                                          .defaultPrinterType ==
                                      PrinterType.network &&
                                  Platform.isWindows,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: TextFormField(
                                  controller: controller
                                      .blueThermalPrinterProdvider
                                      .portController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true),
                                  decoration: const InputDecoration(
                                    label: Text("Port"),
                                    prefixIcon:
                                        Icon(Icons.numbers_outlined, size: 24),
                                  ),
                                  onChanged: controller
                                      .blueThermalPrinterProdvider.setPort,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.blueThermalPrinterProdvider
                                          .defaultPrinterType ==
                                      PrinterType.network &&
                                  Platform.isWindows,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: OutlinedButton(
                                  onPressed: () async {
                                    if (controller.blueThermalPrinterProdvider
                                        .ipController.text.isNotEmpty)
                                      controller.blueThermalPrinterProdvider
                                          .setIpAddress(controller
                                              .blueThermalPrinterProdvider
                                              .ipController
                                              .text);
                                    // controller.printReceiveTest();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 50),
                                    child: Text("Print test ticket",
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.blueThermalPrinterProdvider
                                          .selectedPrinter.value ==
                                      null ||
                                  !controller.blueThermalPrinterProdvider
                                      .isConnected.value) {
                                print("helo");
                              } else {
                                if (controller.blueThermalPrinterProdvider
                                        .selectedPrinter.value !=
                                    null) {
                                  controller.actionOnPrint();
                                  print("helo");
                                }
                              }
                            },

                            // onTap: controller.actionOnPrint,
                            child: Container(
                              height: 85,
                              width: Constants.screenWidth / 2,
                              color: AppColors.deliverySecondary,
                              child: Center(
                                  child: Text(
                                "Print",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.offNamed(Routes.deliveryStoreDetails);
                            },
                            child: Container(
                              height: 85,
                              width: Constants.screenWidth / 2,
                              color: AppColors.deliveryPrimary,
                              child: Center(
                                  child: Text(
                                "Home",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
