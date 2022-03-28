import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class PrintViewView extends StatefulWidget {
  const PrintViewView({Key? key}) : super(key: key);

  @override
  _PrintViewViewState createState() => _PrintViewViewState();
}

class _PrintViewViewState extends State<PrintViewView> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool? isConnected = await bluetoothPrint.isConnected;

    bluetoothPrint.state.listen((state) {
      print('cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected!) {
      setState(() {
        _connected = true;
      });
    }
  }

  printInvoice() async {
    Map<String, dynamic> config = Map();
    List<LineText> list = [];

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'DEMO BILLER',
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        size: 26));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'demo address demo city 001 demo state 01',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        size: 18));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Tel: 00550055',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        size: 18));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'VAT NO: 300926682900003',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        size: 18));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Simple Tax Invoice',
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        size: 18));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Date: 12/12/2021 19:45',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
        size: 14));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Sale No/Ref: SALE00000014',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
        size: 14));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Sale No/Ref: SALE00000014',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
        size: 14));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Sales Associate: MUHAMMED MUHSIN',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
        size: 14));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Customer: Walk In-customer',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1,
        size: 14));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'ITEMS',
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        size: 18));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '------------------------------------',
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
        size: 18));

    //list.add(LineText(type: LineText.TYPE_TEXT, content: 'this is conent left', weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
    //list.add(LineText(type: LineText.TYPE_TEXT, content: 'this is conent right', align: LineText.ALIGN_RIGHT,linefeed: 1));
    //list.add(LineText(linefeed: 1));

    //ByteData data = await rootBundle.load("assets/images/bluetooth_print.png");
    //List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    //String base64Image = base64Encode(imageBytes);
    //list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));

    await bluetoothPrint.printReceipt(config, list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Print View'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map(
                        (d) => ListTile(
                          title: Text(d.name ?? ''),
                          subtitle: Text(d.address!),
                          onTap: () async {
                            setState(() {
                              _device = d;
                            });
                          },
                          trailing:
                              _device != null && _device!.address == d.address
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                        ),
                      )
                      .toList(),
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          child: Text('connect'),
                          onPressed: _connected
                              ? null
                              : () async {
                                  if (_device != null &&
                                      _device!.address != null) {
                                    await bluetoothPrint.connect(_device!);
                                  } else {
                                    setState(() {
                                      tips = 'please select device';
                                    });
                                    print('please select device');
                                  }
                                },
                        ),
                        SizedBox(width: 10.0),
                        OutlinedButton(
                          child: Text('disconnect'),
                          onPressed: _connected
                              ? () async {
                                  await bluetoothPrint.disconnect();
                                }
                              : null,
                        ),
                      ],
                    ),
                    OutlinedButton(
                      child: Text('print receipt(esc)'),
                      onPressed: () {
                        if (_connected) {
                          printInvoice();
                        } else {}
                      },
                    ),
                    OutlinedButton(
                      child: Text('print label(tsc)'),
                      onPressed: _connected
                          ? () async {
                              Map<String, dynamic> config = Map();
                              config['width'] = 40; // 标签宽度，单位mm
                              config['height'] = 70; // 标签高度，单位mm
                              config['gap'] = 2; // 标签间隔，单位mm

                              // x、y坐标位置，单位dpi，1mm=8dpi
                              List<LineText> list = [];
                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,
                                  x: 10,
                                  y: 10,
                                  content: 'A Title'));
                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,
                                  x: 10,
                                  y: 40,
                                  content: 'this is content'));
                              list.add(LineText(
                                  type: LineText.TYPE_QRCODE,
                                  x: 10,
                                  y: 70,
                                  content: 'qrcode i\n'));
                              list.add(LineText(
                                  type: LineText.TYPE_BARCODE,
                                  x: 10,
                                  y: 190,
                                  content: 'qrcode i\n'));

                              List<LineText> list1 = [];
                              ByteData data = await rootBundle
                                  .load("assets/images/guide3.png");
                              List<int> imageBytes = data.buffer.asUint8List(
                                  data.offsetInBytes, data.lengthInBytes);
                              String base64Image = base64Encode(imageBytes);
                              list1.add(LineText(
                                type: LineText.TYPE_IMAGE,
                                x: 10,
                                y: 10,
                                content: base64Image,
                              ));

                              await bluetoothPrint.printLabel(config, list);
                              await bluetoothPrint.printLabel(config, list1);
                            }
                          : null,
                    ),
                    OutlinedButton(
                      child: Text('print selftest'),
                      onPressed: _connected
                          ? () async {
                              await bluetoothPrint.printTest();
                            }
                          : null,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: bluetoothPrint.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => bluetoothPrint.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () =>
                    bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

// class PrintViewView extends GetView<PrintViewController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PrintViewView'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           'PrintViewView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
