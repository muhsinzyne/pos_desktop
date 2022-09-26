// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:get/state_manager.dart';
import 'package:posdelivery/app/modules/pos-delivery/sale-invoice/controllers/delivery_sale_invoice_controller.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/product_row.dart';

class DeliverySaleInvoiceScreen
    extends GetView<DeliverySaleInvoiceScreenController> {
  const DeliverySaleInvoiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                      onPressed:
                                          controller.selectedPrinter.value ==
                                                      null ||
                                                  controller.isConnected.value
                                              ? null
                                              : () {
                                                  controller.connectDevice();
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
                                      onPressed:
                                          controller.selectedPrinter.value ==
                                                      null ||
                                                  !controller.isConnected.value
                                              ? null
                                              : () {
                                                  if (controller.selectedPrinter
                                                          .value !=
                                                      null)
                                                    controller.printerManager
                                                        .disconnect(
                                                            type: controller
                                                                .selectedPrinter
                                                                .value!
                                                                .typePrinter);
                                                  controller.isConnected.value =
                                                      false;
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
                            value: controller.defaultPrinterType,
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
                                controller.defaultPrinterType = value;
                                controller.selectedPrinter.value = null;
                                controller.isBle.value = false;
                                controller.isConnected.value = false;
                                controller.scan();
                              }
                            },
                          ),
                          Visibility(
                            visible: controller.defaultPrinterType ==
                                    PrinterType.bluetooth &&
                                Platform.isAndroid,
                            child: SwitchListTile.adaptive(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 20.0, left: 20),
                              title: const Text(
                                "This device supports ble (low energy)",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 19.0),
                              ),
                              value: controller.isBle.value,
                              onChanged: (bool? value) {
                                controller.isBle.value = value ?? false;
                                controller.isConnected.value = false;
                                controller.selectedPrinter.value = null;
                                controller.scan();
                              },
                            ),
                          ),
                          Visibility(
                            visible: controller.defaultPrinterType ==
                                    PrinterType.bluetooth &&
                                Platform.isAndroid,
                            child: SwitchListTile.adaptive(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 20.0, left: 20),
                              title: const Text(
                                "reconnect",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 19.0),
                              ),
                              value: controller.reconnect.value,
                              onChanged: (bool? value) {
                                controller.reconnect.value = value ?? false;
                              },
                            ),
                          ),
                          Obx(() {
                            return Column(
                                children: controller.devices
                                    .map(
                                      (device) => ListTile(
                                        title: Text('${device.deviceName}'),
                                        subtitle: Platform.isAndroid &&
                                                controller.defaultPrinterType ==
                                                    PrinterType.usb
                                            ? null
                                            : Visibility(
                                                visible: !Platform.isWindows,
                                                child:
                                                    Text("${device.address}")),
                                        onTap: () {
                                          // do something
                                          controller.selectDevice(device);
                                          controller.update();
                                        },
                                        leading: controller.selectedPrinter
                                                        .value !=
                                                    null &&
                                                ((device.typePrinter ==
                                                                PrinterType
                                                                    .usb &&
                                                            Platform.isWindows
                                                        ? device.deviceName ==
                                                            controller
                                                                .selectedPrinter
                                                                .value!
                                                                .deviceName
                                                        : device.vendorId !=
                                                                null &&
                                                            controller
                                                                    .selectedPrinter
                                                                    .value!
                                                                    .vendorId ==
                                                                device
                                                                    .vendorId) ||
                                                    (device.address != null &&
                                                        controller
                                                                .selectedPrinter
                                                                .value!
                                                                .address ==
                                                            device.address))
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              )
                                            : null,
                                        trailing: OutlinedButton(
                                          onPressed: controller.selectedPrinter
                                                          .value ==
                                                      null ||
                                                  device.deviceName !=
                                                      controller.selectedPrinter
                                                          .value!.deviceName
                                              ? null
                                              : () async {
                                                  controller.printReceiveTest();
                                                },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 20),
                                            child: Text("Print test ticket",
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList());
                          }),
                          Visibility(
                            visible: controller.defaultPrinterType ==
                                    PrinterType.network &&
                                Platform.isWindows,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                controller: controller.ipController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true),
                                decoration: const InputDecoration(
                                  label: Text("Ip Address"),
                                  prefixIcon: Icon(Icons.wifi, size: 24),
                                ),
                                onChanged: controller.setIpAddress,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.defaultPrinterType ==
                                    PrinterType.network &&
                                Platform.isWindows,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                controller: controller.portController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true),
                                decoration: const InputDecoration(
                                  label: Text("Port"),
                                  prefixIcon:
                                      Icon(Icons.numbers_outlined, size: 24),
                                ),
                                onChanged: controller.setPort,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.defaultPrinterType ==
                                    PrinterType.network &&
                                Platform.isWindows,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: OutlinedButton(
                                onPressed: () async {
                                  if (controller.ipController.text.isNotEmpty)
                                    controller.setIpAddress(
                                        controller.ipController.text);
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
                            if (controller.selectedPrinter.value == null ||
                                !controller.isConnected.value) {
                            } else {
                              if (controller.selectedPrinter.value != null)
                                controller.actionOnPrint();
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
                          onTap: controller.printBig,
                          child: Container(
                            height: 85,
                            width: Constants.screenWidth / 2,
                            color: AppColors.deliveryPrimary,
                            child: Center(
                                child: Text(
                              "PDF Big",
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
    );
  }
}
