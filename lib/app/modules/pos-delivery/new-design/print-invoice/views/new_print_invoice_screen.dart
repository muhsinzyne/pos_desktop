// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/print-invoice/controllers/new_print_invoice_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';

class NewPrintInvoiceScreen extends GetView<NewPrintInvoiceScreenController> {
  const NewPrintInvoiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(
              Icons.print_outlined,
              size: 30,
              color: AppColors.newPrimary,
            ),
            //  SvgPicture.asset(
            //   "assets/svg/cart.svg",
            //   fit: BoxFit.fitHeight,
            // ),
            backgroundColor: AppColors.newSecondary,
            onPressed: () {
              if (controller
                          .blueThermalPrinterProdvider.selectedPrinter.value ==
                      null ||
                  !controller.blueThermalPrinterProdvider.isConnected.value) {
                Get.snackbar("Printer", "Not Connected");
              } else {
                if (controller
                        .blueThermalPrinterProdvider.selectedPrinter.value !=
                    null) {
                  controller.actionOnPrint();
                }
              }
            },
          ),
        ),
      ),
      appBar: DeliveryAppBar(
        appBar: AppBar(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.newSecondary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SvgPicture.asset(
                "assets/svg/menu.svg",
                height: 30,
                color: AppColors.newIconColor,
                width: 30,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(icon: SizedBox(), label: ""),
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                            value: controller
                                .blueThermalPrinterProdvider.defaultPrinterType,
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
                          Obx(() {
                            return Visibility(
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
                            );
                          }),
                          Obx(() {
                            return Visibility(
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
                            );
                          }),
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
                                                child:
                                                    Text("${device.address}")),
                                        onTap: () {
                                          // do something
                                          controller.blueThermalPrinterProdvider
                                              .selectDevice(device);
                                          controller.blueThermalPrinterProdvider
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
                                                        : device.vendorId !=
                                                                null &&
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
                                    .blueThermalPrinterProdvider.portController,
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
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
