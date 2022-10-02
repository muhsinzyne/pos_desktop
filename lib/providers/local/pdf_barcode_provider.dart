import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';
import 'package:posdelivery/models/response/pos/sales_customer.dart';

class PdfBarcodeProvider {
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<File> generate() async {
    // final logoImage = await networkImage(invoice.logoPath);
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 0 * PdfPageFormat.cm,
        marginLeft: 0 * PdfPageFormat.cm,
        marginRight: 0 * PdfPageFormat.cm,
        marginTop: 0 * PdfPageFormat.cm,
      ),
      // pageFormat: PdfPageFormat(
      //   9 * PdfPageFormat.cm,
      //   2 * PdfPageFormat.cm,
      //   marginAll: 0.2size * PdfPageFormat.cm,
      // ),

      orientation: pw.PageOrientation.portrait,
      build: (context) => buildTitle(),
    ));

    return saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static pw.Widget buildBarcode() => pw.Container(
        decoration: pw.BoxDecoration(
            border: pw.Border.all(
              width: 1,
            ),
            borderRadius: pw.BorderRadius.circular(0.3 * PdfPageFormat.cm)),
        height: 2 * PdfPageFormat.cm,
        width: 3 * PdfPageFormat.cm,
        padding: pw.EdgeInsets.symmetric(
          horizontal: 0.4 * PdfPageFormat.cm,
          vertical: 0.3 * PdfPageFormat.cm,
        ),
        child: pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
      );
  static double size = 25;
  static pw.Widget buildTitle() =>
      //  pw.Padding(
      //       padding: pw.EdgeInsets.symmetric(horizontal: size),
      //       child: pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
      //     );
      // pw.Row(mainAxisSize: pw.MainAxisSize.min, children: [
      //   pw.Padding(
      //     padding: pw.EdgeInsets.symmetric(horizontal: size),
      //     child: pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
      //   ),
      //   pw.Padding(
      //     padding: pw.EdgeInsets.symmetric(horizontal: size),
      //     child: pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
      //   ),
      //   pw.Padding(
      //     padding: pw.EdgeInsets.symmetric(horizontal: size),
      //     child: pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
      //   )
      // ]);
      pw.Column(children: [
        pw.Container(
          width: 9.5 * PdfPageFormat.cm,
          padding: pw.EdgeInsets.only(
              top: 0.4 * PdfPageFormat.cm,
              left: 0.1 * PdfPageFormat.cm,
              right: 0.1 * PdfPageFormat.cm),
          child: pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              buildBarcode(),
              buildBarcode(),
              buildBarcode(),
            ],
          ),
        ),
        pw.Container(
          width: 9.5 * PdfPageFormat.cm,
          padding: pw.EdgeInsets.only(
              top: 0.4 * PdfPageFormat.cm,
              left: 0.1 * PdfPageFormat.cm,
              right: 0.1 * PdfPageFormat.cm),
          child: pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              buildBarcode(),
              buildBarcode(),
              buildBarcode(),
            ],
          ),
        ),
        pw.Container(
          width: 9.5 * PdfPageFormat.cm,
          padding: pw.EdgeInsets.only(
              top: 0.4 * PdfPageFormat.cm,
              left: 0.1 * PdfPageFormat.cm,
              right: 0.1 * PdfPageFormat.cm),
          child: pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              buildBarcode(),
              buildBarcode(),
              buildBarcode(),
            ],
          ),
        ),
        pw.Container(
          width: 9.5 * PdfPageFormat.cm,
          padding: pw.EdgeInsets.only(
              top: 0.4 * PdfPageFormat.cm,
              left: 0 * PdfPageFormat.cm,
              right: 0 * PdfPageFormat.cm),
          child: pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              buildBarcode(),
              buildBarcode(),
              buildBarcode(),
            ],
          ),
        ),
      ]);

  // pw.GridView(
  //   crossAxisCount: 3,
  //   crossAxisSpacing: 2 * PdfPageFormat.cm,
  //   mainAxisSpacing: 2 * PdfPageFormat.cm,
  //   childAspectRatio: 0.8,
  //   padding: pw.EdgeInsets.zero,
  //   children: [
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  //     pw.Padding(
  //       padding: pw.EdgeInsets.symmetric(horizontal: size),
  //       child:
  //           pw.BarcodeWidget(data: "sasa", barcode: pw.Barcode.code128()),
  //     ),
  // ],
  // );
}
