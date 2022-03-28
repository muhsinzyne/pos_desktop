import 'dart:io';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:posdelivery/app/modules/contracts.dart';
import 'package:posdelivery/app/modules/pos/print-view/contracts.dart';
import 'package:posdelivery/app/test_print.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/providers/local/base_print_provider.dart';

import '../../models/response/pos/product_row.dart';
import '../../models/response/static/tax_summary.dart';

class PrintProvider extends BasePrintProvider {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  IBaseGetXController? bCtrl;
  IPrintScreenController? pCtrl;

  RxList<BluetoothDevice> allList = RxList([]);
  List<BluetoothDevice> devices = [];
  BluetoothDevice? _device;
  TestPrint? testPrint;
  String logoImage = '';
  final RxBool connected = RxBool(false);
  final RxBool _printerConn = RxBool(false);
  RxString conMsg = RxString('no_connected_devise'.tr);
  BluetoothDevice get device => _device!;
  bool get printerConn {
    // if (_printerConn.isTrue) {
    //   conMsg.value = 'printer_connected_to'.tr + " " + (device?.name ?? '');
    // } else {
    //   conMsg.value = 'printer_not_connected'.tr;
    // }
    return _printerConn.value;
  }

  set device(BluetoothDevice newRequest) {
    disconnect();
    _device = newRequest;
  }

  set printerConn(bool value) {
    _printerConn.value = value;
  }

  set callBack(IBaseGetXController controller) {
    bCtrl = controller;
  }

  set printViewCallBack(IPrintScreenController controller) {
    pCtrl = controller;
  }

  @override
  void onInit() {
    //loadImage();
    super.onInit();
  }

  @override
  void onReady() {
    initPlatformState();
    super.onReady();
  }

  void disconnect() {
    bluetooth.disconnect().then((value) {
      connected.value = false;
      conMsg.value = 'printer_disconnected'.tr;
    }).catchError((error) {
      connected.value = false;
      conMsg.value = 'printer_not_connected'.tr;
    });
  }

  void connect() {
    if (device == null) {
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(device).then((con) {
            connected.value = true;
            conMsg.value =
                'printer_connected_to'.tr + " " + (device.name ?? '');
          }).catchError((error) {
            connected.value = false;
            conMsg.value =
                'requested_device_not_supported'.tr + " " + (device.name ?? '');
          });
        }
      });
    }
  }

  Future refreshBluetoothScan() async {
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> tempList = [];
    try {
      devices = await bluetooth.getBondedDevices();
      allList.value = devices;
      print(devices);
    } on PlatformException {
      // TODO - Error
      print("exeptions");
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          connected.value = true;
          break;
        case BlueThermalPrinter.DISCONNECTED:
          connected.value = false;
          break;
        default:
          print(state);
          break;
      }
    });
    if (isConnected!) {
      connected.value = true;
    }
  }

  Future<dynamic> downloadImage(filename, url) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');

    if (file.existsSync()) {
      var image = await file.readAsBytes();
      logoImage = '$dir/$filename';
      return image;
    } else {
      var request = await http.get(
        Uri.parse(url),
      );
      var bytes = request.bodyBytes;
      await file.writeAsBytes(bytes);
      logoImage = '$dir/$filename';
      return bytes;
    }
  }

  void loadImage(String url) async {
    print(url);
    var filename = Uri.parse(url).pathSegments.last;
    await downloadImage(filename, url).then((bytes) {
      return true;
    });
  }

  void printPosInvoice(InvoiceResponse invoiceResponse) {
    String telTitle = 'tel'.tr;
    String vatTitle = 'vat'.tr;
    String invoiceTitle =
        invoiceResponse.inv!.saleStatus == SalesStatus.returned
            ? 'return_invoice'.tr.toUpperCase()
            : 'simple_tax_invoice'.tr.toUpperCase();

    String dateTitle = 'date'.tr.toUpperCase();
    String saleRefNo = 'sales_ref_no'.tr;
    String salesAssociate = 'sales_associate'.tr;
    String customer = 'customer'.tr;
    String itemsString = 'items'.tr.toUpperCase();
    bluetooth.isConnected.then((isConnected) {
      bluetooth.printImage(logoImage);
      bluetooth.printNewLine();
      bluetooth.printCustom(invoiceResponse.biller!.name!, 1, 1);
      bluetooth.printCustom(invoiceResponse.biller!.address!, 0, 1);
      bluetooth.printCustom(
          telTitle + ": " + invoiceResponse.biller!.phone!, 0, 1);
      bluetooth.printCustom(
          vatTitle + ": " + invoiceResponse.biller!.vatNo!, 1, 1);
      bluetooth.printCustom(invoiceTitle, 1, 1);
      bluetooth.printNewLine();
      bluetooth.printCustom(
          dateTitle + " : " + invoiceResponse.inv!.date!, 0, 0);
      bluetooth.printCustom(
          saleRefNo + " : " + invoiceResponse.inv!.referenceNo!, 0, 0);
      bluetooth.printCustom(
          salesAssociate +
              " : " +
              invoiceResponse.createdBy!.firstName! +
              ' ' +
              invoiceResponse.createdBy!.lastName!,
          0,
          0);
      bluetooth.printCustom(
          customer + " : " + invoiceResponse.customer!.name!, 0, 0);
      bluetooth.printNewLine();
      bluetooth.printCustom(itemsString, 1, 1);
      bluetooth.printCustom("-------------------------------------", 0, 1);
      List<TaxSummaryList> taxSummaryList = [];
      for (int i = 0; i < invoiceResponse.rows.length; i++) {
        Rows cRows = invoiceResponse.rows[i];
        if (cRows.taxName != Constants.none || cRows.taxCode != null) {
          var taxIndex =
              taxSummaryList.indexWhere((tax) => tax.id == cRows.taxRateId);
          if (taxIndex == Constants.unDefinedIndex) {
            TaxSummaryList newTaxList = TaxSummaryList();
            newTaxList.id = cRows.taxRateId;
            newTaxList.name = cRows.taxName;
            newTaxList.qty = double.tryParse(cRows.quantity!)!;
            newTaxList.taxEx = double.tryParse(cRows.netUnitPrice!)!;
            newTaxList.taxAmt = double.tryParse(cRows.itemTax!)!;
            taxSummaryList.add(newTaxList);
          } else {
            TaxSummaryList newTaxList = taxSummaryList[taxIndex];
            newTaxList.qty = newTaxList.qty + double.tryParse(cRows.quantity!)!;
            newTaxList.taxEx =
                newTaxList.taxEx + double.tryParse(cRows.netUnitPrice!)!;
            newTaxList.taxAmt =
                newTaxList.taxAmt + double.tryParse(cRows.itemTax!)!;
            taxSummaryList[taxIndex] = newTaxList;
          }
        }

        var currentNo = (i + 1).toString();
        bluetooth.printLeftRight(
            "#" + currentNo + ": " + cRows.productName!, cRows.taxCode!, 0);
        bluetooth.printLeftRight(
          double.tryParse(cRows.quantity!)!.toStringAsFixed(1) +
              " x " +
              double.tryParse(cRows.realUnitPrice!)!.toStringAsFixed(2) +
              "- " +
              'tax'.tr +
              "(" +
              (cRows.taxName ?? '') +
              ") - " +
              double.tryParse(cRows.itemTax!)!.toStringAsFixed(2) +
              "",
          double.tryParse(cRows.subtotal!)!.toStringAsFixed(2),
          0,
        );
      }
      bluetooth.printCustom("----------------------------------", 0, 1);
      bluetooth.printLeftRight(
          'sub_total'.tr + ": ", invoiceResponse.total.toStringAsFixed(2), 1);
      bluetooth.printLeftRight(
          'tax'.tr + ": ", invoiceResponse.totalTax.toStringAsFixed(2), 1);
      bluetooth.printLeftRight('grand_total'.tr + ": ",
          invoiceResponse.grandTotal.toStringAsFixed(2), 1);
      bluetooth.printCustom("----------------------------------", 0, 1);
      for (var payment in invoiceResponse.payments!) {
        var paidAmount = double.tryParse(payment.posPaid!) == 0.0
            ? double.tryParse(payment.amount!)
            : double.tryParse(payment.posPaid!);
        var returnedString =
            payment.returnId != null ? " (" + 'returned'.tr + ") " : " ";
        var paidString = paidAmount!.toStringAsFixed(2) + returnedString;
        var change = double.tryParse(payment.posBalance!)! > 0
            ? double.tryParse(payment.posBalance!)
            : 0.0;
        bluetooth.print3Column(
            'paid_by'.tr + ": " + payment.paidBy!,
            'amount'.tr + ": " + paidString,
            'change'.tr + ": " + change!.toStringAsFixed(1),
            1);
      }
      bluetooth.printNewLine();

      bluetooth.printCustom('tax_summary'.tr.toUpperCase(), 1, 0);
      bluetooth.print4Column('name'.tr, 'qty'.tr, 'tax_ex'.tr, 'tax_amt'.tr, 0);
      for (var tax in taxSummaryList) {
        bluetooth.print4Column(tax.name!, tax.qty.toStringAsFixed(1),
            tax.taxEx.toStringAsFixed(2), tax.taxAmt.toStringAsFixed(2), 0);
      }

      bluetooth.printQRcode(invoiceResponse.qrCodeString, 200, 200, 1);
      bluetooth.printCustom('tank_you'.tr, 0, 1);
      bluetooth.paperCut();
    });
  }
}
