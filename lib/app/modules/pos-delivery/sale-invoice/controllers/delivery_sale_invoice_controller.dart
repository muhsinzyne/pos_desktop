import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posdelivery/app/modules/pos-delivery/sale-invoice/contracts.dart';
import 'package:posdelivery/app/modules/pos/print-view/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/navigation/print_view_nav.dart';
import 'package:posdelivery/models/requests/pos/sale_view_request.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';
import 'package:posdelivery/providers/local/pdf_invoice_provider.dart';
import 'package:posdelivery/providers/local/pdf_small_invoice_provider.dart';
import 'package:posdelivery/providers/local/print_provider.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/providers/local/base_print_provider.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

class DeliverySaleInvoiceScreenController extends BaseGetXController
    implements IDeliverySaleInvoiceScreenController {
  var defaultPrinterType = PrinterType.bluetooth;
  final RxBool isBle = RxBool(false);
  final RxBool reconnect = RxBool(false);
  final RxBool isConnected = RxBool(false);
  var printerManager = PrinterManager.instance;
  var devices = <BluetoothPrinter>[].obs;
  StreamSubscription<PrinterDevice>? subscription;
  StreamSubscription<BTStatus>? subscriptionBtStatus;
  StreamSubscription<USBStatus>? subscriptionUsbStatus;
  BTStatus currentStatus = BTStatus.none;
  // _currentUsbStatus is only supports on Android
  USBStatus currentUsbStatus = USBStatus.none;
  List<int>? pendingTask;
  String ipAddress = '';
  String port = '9100';
  final ipController = TextEditingController();
  final portController = TextEditingController();
  String logoImage = '';
  Uint8List? logoBytes;
  // BluetoothPrinter? selectedPrinter;
  // Rx<BluetoothPrinter test = BluetoothPrinter();
  Rxn<BluetoothPrinter> selectedPrinter = Rxn<BluetoothPrinter>();

  Future<void> initPlatformState() async {
    if (Platform.isWindows) defaultPrinterType = PrinterType.usb;
    portController.text = port;
    scan();

    // subscription to listen change status of bluetooth connection
    subscriptionBtStatus =
        PrinterManager.instance.stateBluetooth.listen((status) {
      log(' ----------------- status bt $status ------------------ ');
      currentStatus = status;
      if (status == BTStatus.connected) {
        isConnected.value = true;
      }
      if (status == BTStatus.none) {
        isConnected.value = false;
      }
      if (status == BTStatus.connected && pendingTask != null) {
        if (Platform.isAndroid) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance
                .send(type: PrinterType.bluetooth, bytes: pendingTask!);
            pendingTask = null;
          });
        } else if (Platform.isIOS) {
          PrinterManager.instance
              .send(type: PrinterType.bluetooth, bytes: pendingTask!);
          pendingTask = null;
        }
      }
    });
    //  PrinterManager.instance.stateUSB is only supports on Android
    subscriptionUsbStatus = PrinterManager.instance.stateUSB.listen((status) {
      log(' ----------------- status usb $status ------------------ ');
      currentUsbStatus = status;
      if (Platform.isAndroid) {
        if (status == USBStatus.connected && pendingTask != null) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance
                .send(type: PrinterType.usb, bytes: pendingTask!);
            pendingTask = null;
          });
        }
      }
    });
  }

  @override
  void onReady() {
    UINotification.showLoading();
    initPlatformState();
    super.onReady();
  }

  @override
  void onClose() {
    subscription?.cancel();
    subscriptionBtStatus?.cancel();
    subscriptionUsbStatus?.cancel();
    portController.dispose();
    ipController.dispose();
    super.onClose();
  }

  // method to scan devices according PrinterType
  void scan() {
    devices.clear();
    subscription = printerManager
        .discovery(type: defaultPrinterType, isBle: isBle.value)
        .listen((device) {
      devices.add(BluetoothPrinter(
        deviceName: device.name,
        address: device.address,
        isBle: isBle.value,
        vendorId: device.vendorId,
        productId: device.productId,
        typePrinter: defaultPrinterType,
      ));
      refresh();
    });
  }

  void setPort(String value) {
    if (value.isEmpty) value = '9100';
    port = value;
    var device = BluetoothPrinter(
      deviceName: value,
      address: ipAddress,
      port: port,
      typePrinter: PrinterType.network,
      state: false,
    );
    selectDevice(device);
  }

  void setIpAddress(String value) {
    ipAddress = value;
    var device = BluetoothPrinter(
      deviceName: value,
      address: ipAddress,
      port: port,
      typePrinter: PrinterType.network,
      state: false,
    );
    selectDevice(device);
  }

  void selectDevice(BluetoothPrinter device) async {
    if (selectedPrinter.value != null) {
      if ((device.address != selectedPrinter.value?.address) ||
          (device.typePrinter == PrinterType.usb &&
              selectedPrinter.value!.vendorId != device.vendorId)) {
        await PrinterManager.instance
            .disconnect(type: selectedPrinter.value!.typePrinter);
      }
    }

    selectedPrinter.value = device;
    refresh();
  }

  Future<dynamic> downloadImage(filename, url) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');

    if (file.existsSync()) {
      var image = await file.readAsBytes();
      logoImage = '$dir/$filename';
      logoBytes = image;
      return image;
    } else {
      var request = await http.get(
        Uri.parse(url),
      );
      var bytes = request.bodyBytes;
      await file.writeAsBytes(bytes);
      logoImage = '$dir/$filename';
      logoBytes = bytes;
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

  // Future printReceiveTest() async {
  //   final profile = await CapabilityProfile.load();
  //   final generator = Generator(PaperSize.mm58, profile);
  //   List<int> bytes = [];
  //   final Uint8List imgBytes = logoBytes!;
  //   final img.Image? image = img.decodeImage(imgBytes);
  //   bytes += generator.image(
  //     image!,
  //   );
  //   bytes += generator.text('${invoiceResponse.value.inv?.biller}',
  //       styles: PosStyles(
  //         align: PosAlign.center,
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2,
  //       ),
  //       linesAfter: 1);
  //   bytes += generator.text(
  //     '${invoiceResponse.value.customer?.address}',
  //     styles: const PosStyles(
  //       align: PosAlign.center,
  //     ),
  //     linesAfter: 1,
  //   );
  //   bytes += generator.row([
  //     PosColumn(
  //       text: 'col3',
  //       width: 3,
  //       styles: const PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //     PosColumn(
  //       text: 'col6',
  //       width: 6,
  //       styles: const PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //     PosColumn(
  //       text: 'col3',
  //       width: 3,
  //       styles: const PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //   ]);

  //   bytes += generator.qrcode(invoiceResponse.value.qrCodeString,
  //       size: QRSize.Size7);
  //   bytes += generator.setGlobalCodeTable('CP1252');
  //   printEscPos(bytes, generator);
  // }
  Future printReceiveTest() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];
    final Uint8List imgBytes = logoBytes!;
    final img.Image? image = img.decodeImage(imgBytes);
    InvoiceResponse invoice = invoiceResponse.value;
    bytes += generator.image(
      image!,
    );
    bytes += generator.text(
      '${invoice.inv?.biller}',
      styles: PosStyles(
        align: PosAlign.center,
        bold: true,
      ),
    );
    bytes += generator.text(
      '${invoice.customer?.address}',
      styles: const PosStyles(
        align: PosAlign.center,
      ),
    );
    bytes += generator.text(
      'Tel: ${invoice.customer?.phone} ',
      styles: const PosStyles(
        align: PosAlign.center,
      ),
    );
    bytes += generator.text(
      'VatNo: ${invoice.biller?.vatNo} ',
      styles: const PosStyles(
        align: PosAlign.center,
      ),
      linesAfter: 1,
    );
    bytes += generator.text(
      'Simple Tax Invoice',
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size3,
        bold: true,
        width: PosTextSize.size3,
      ),
      linesAfter: 1,
    );
    bytes += generator.text(
      'Date: ${invoice.inv?.date} ',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );
    bytes += generator.text(
      'sl no: ${invoice.inv?.saleId} ',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );
    bytes += generator.text(
      'Sale No/Ref: ${invoice.inv?.referenceNo} ',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );
    bytes += generator.text(
      'Sales Associate: MUHAMMED MUHSIN',
      styles: const PosStyles(
        align: PosAlign.left,
      ),
    );
    bytes += generator.text('Customer: ${invoice.inv?.customer}',
        styles: const PosStyles(
          align: PosAlign.left,
        ),
        linesAfter: 1);
    bytes += generator.text(
      'ITEMS',
      styles: PosStyles(
        align: PosAlign.center,
        bold: true,
      ),
    );
    bytes += generator.row([
      PosColumn(
        text: 'Item',
        width: 3,
        styles: const PosStyles(
          align: PosAlign.left,
          underline: true,
        ),
      ),
      PosColumn(
        text: 'Qty',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.left,
          underline: true,
        ),
      ),
      PosColumn(
        text: 'Unit Price',
        width: 4,
        styles: const PosStyles(
          align: PosAlign.left,
          underline: true,
        ),
      ),
      PosColumn(
        text: 'Price',
        width: 3,
        styles: const PosStyles(
          align: PosAlign.left,
          underline: true,
        ),
      ),
    ]);
    bytes += generator.hr(ch: '-');
    double unitQuantity;
    double unitPrice;
    double subTotal;
    for (var i = 0; i < invoice.rows.length; i++) {
      bytes += generator.row([
        PosColumn(
          text: '#${i + 1}: ${invoice.rows[i].productName}',
          width: 12,
          styles: const PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
      unitQuantity = double.parse(invoice.rows[i].unitQuantity ?? "0");
      unitPrice = double.parse(invoice.rows[i].unitPrice ?? "0");
      subTotal = double.parse(invoice.rows[i].subtotal ?? "0");
      bytes += generator.row([
        PosColumn(
          text: '',
          width: 3,
          styles: const PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: unitQuantity.toStringAsFixed(2),
          width: 2,
          styles: const PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: unitPrice.toStringAsFixed(2),
          width: 4,
          styles: const PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: subTotal.toStringAsFixed(2),
          width: 3,
          styles: const PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
    }
    bytes += generator.hr(ch: '-');
    bytes += generator.row([
      PosColumn(
        text: 'Total Item: ${invoice.rows.length}',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: 'Total Qty: ${invoice.inv?.totalItems}',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.left,
        ),
      ),
    ]);
    double grandTotal = double.parse(invoice.inv?.grandTotal ?? "0");
    bytes += generator.row([
      PosColumn(
        text: 'Sub total',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: grandTotal.toStringAsFixed(2),
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Discount',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: '0',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);
    double totalTax = double.parse(invoice.inv?.totalTax ?? "0");
    bytes += generator.row([
      PosColumn(
        text: 'Vat(15%)',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: totalTax.toStringAsFixed(2),
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);
    double netTotal = grandTotal + totalTax;
    bytes += generator.row([
      PosColumn(
        text: 'Net Total',
        width: 6,
        styles: const PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold: true,
        ),
      ),
      PosColumn(
        text: netTotal.toStringAsFixed(2),
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
          bold: true,
        ),
      ),
    ]);
    bytes += generator.qrcode(invoiceResponse.value.qrCodeString,
        size: QRSize.Size7);
    printEscPos(bytes, generator);
  }

  /// print ticket
  void printEscPos(List<int> bytes, Generator generator) async {
    if (selectedPrinter == null) return;
    var bluetoothPrinter = selectedPrinter.value;

    switch (bluetoothPrinter?.typePrinter) {
      case PrinterType.usb:
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter!.typePrinter,
            model: UsbPrinterInput(
                name: bluetoothPrinter.deviceName,
                productId: bluetoothPrinter.productId,
                vendorId: bluetoothPrinter.vendorId));
        pendingTask = null;
        if (Platform.isAndroid) pendingTask = bytes;
        break;
      case PrinterType.bluetooth:
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter!.typePrinter,
            model: BluetoothPrinterInput(
                name: bluetoothPrinter.deviceName,
                address: bluetoothPrinter.address!,
                isBle: bluetoothPrinter.isBle ?? false,
                autoConnect: reconnect.value));
        pendingTask = null;
        if (Platform.isIOS || Platform.isAndroid) pendingTask = bytes;
        break;
      case PrinterType.network:
        bytes += generator.feed(2);
        bytes += generator.cut();
        await printerManager.connect(
            type: bluetoothPrinter!.typePrinter,
            model: TcpPrinterInput(ipAddress: bluetoothPrinter.address!));
        break;
      default:
    }
    if (bluetoothPrinter!.typePrinter == PrinterType.bluetooth) {
      if (currentStatus == BTStatus.connected) {
        printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
        pendingTask = null;
      }
    } else if (bluetoothPrinter.typePrinter == PrinterType.usb &&
        Platform.isAndroid) {
      // _currentUsbStatus is only supports on Android
      if (currentUsbStatus == USBStatus.connected) {
        printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
        pendingTask = null;
      }
    } else {
      printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);
    }
  }

  // conectar dispositivo
  connectDevice() async {
    isConnected.value = false;
    if (selectedPrinter == null) return;
    switch (selectedPrinter.value!.typePrinter) {
      case PrinterType.usb:
        await printerManager.connect(
            type: selectedPrinter.value!.typePrinter,
            model: UsbPrinterInput(
                name: selectedPrinter.value!.deviceName,
                productId: selectedPrinter.value!.productId,
                vendorId: selectedPrinter.value!.vendorId));
        isConnected.value = true;
        break;
      case PrinterType.bluetooth:
        await printerManager.connect(
            type: selectedPrinter.value!.typePrinter,
            model: BluetoothPrinterInput(
                name: selectedPrinter.value!.deviceName,
                address: selectedPrinter.value!.address!,
                isBle: selectedPrinter.value!.isBle ?? false,
                autoConnect: reconnect.value));
        break;
      case PrinterType.network:
        await printerManager.connect(
            type: selectedPrinter.value!.typePrinter,
            model: TcpPrinterInput(ipAddress: selectedPrinter.value!.address!));
        isConnected.value = true;
        break;
      default:
    }

    refresh();
  }

//--------------------------//
  PrintProvider printProvider = Get.find<PrintProvider>();
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();

  PrintViewNavParams? params;
  Rx<InvoiceResponse> invoiceResponse = InvoiceResponse().obs;

  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  // List<Employee> employees = <Employee>[];

  // late EmployeeDataSource employeeDataSource;
  // @override
  // void onInit() {
  //   deliveryDataProvider.deliverySaleInvoiceCtrl = this;
  //   // params = Get.arguments;
  //   // if (params!.refId != null) {
  //   _fetchInvoice();
  //   // }

  //   super.onInit();
  // }
  @override
  void onInit() {
    deliveryDataProvider.deliverySaleInvoiceCtrl = this;
    params = Get.arguments;
    // if (params?.refId != null) {
    _fetchInvoice();
    // }
    super.onInit();
  }

  _fetchInvoice() {
    SaleViewRequest saleViewRequest = SaleViewRequest();
    // saleViewRequest.saleId = params!.refId;
    saleViewRequest.saleId = "220";
    deliveryDataProvider.getSaleInvoice(saleViewRequest);
  }

  @override
  onSaleViewError(ErrorMessage errorMessage) {
    UINotification.hideLoading();
    print(errorMessage);
  }

  @override
  onSaleViewFetchDone(InvoiceResponse dataResponse) {
    isLoading.value = false;
    UINotification.hideLoading();
    invoiceResponse.value = dataResponse;
    logger.e("done");
  }

  @override
  actionOnPrint() async {
    UINotification.showLoading();
    // printProvider.loadImage(invoiceResponse.value.logoPath);
    loadImage(invoiceResponse.value.logoPath);
    await Future.delayed(Duration(seconds: 1));
    printReceiveTest();

    // logger.e(invoiceResponse.value.totalTax);
    // logger.e(invoiceResponse.value.inv?.totalTax);
    // logger.e(invoiceResponse.value.inv?.orderTax);
    // logger.e(invoiceResponse.value.inv?.productTax);
    // final pffFile =
    // await PdfSmallInvoiceProvider.generate(invoiceResponse.value);
    // PdfSmallInvoiceProvider.openFile(pffFile);

    // printProvider.printPosInvoice(invoiceResponse.value);

    UINotification.hideLoading();
  }

  printBig() async {
    // UINotification.showLoading();
    // printProvider.loadImage(invoiceResponse.value.logoPath);
    // PdfInvoiceProvider.loadImage(invoiceResponse.value.logoPath);
    await Future.delayed(Constants.smallDuration);
    final pffFile = await PdfInvoiceProvider.generate(invoiceResponse.value);
    PdfInvoiceProvider.openFile(pffFile);

    // printProvider.connect();
    // printProvider.printPosInvoice(invoiceResponse.value);

    UINotification.hideLoading();
  }
}

class BluetoothPrinter {
  int? id;
  String? deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  bool? isBle;

  PrinterType typePrinter;
  bool? state;

  BluetoothPrinter(
      {this.deviceName,
      this.address,
      this.port,
      this.state,
      this.vendorId,
      this.productId,
      this.typePrinter = PrinterType.bluetooth,
      this.isBle = false});
}
