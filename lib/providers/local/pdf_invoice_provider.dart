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

class PdfInvoiceProvider {
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

  static Future<File> generate(InvoiceResponse invoice) async {
    final logoImage = await networkImage(invoice.logoPath);
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      build: (context) => [
        buildTitle(invoice, logoImage),
      ],
    ));

    return saveDocument(name: 'invoice_${invoice.inv?.id}.pdf', pdf: pdf);
  }

  static pw.Widget buildTitle(InvoiceResponse invoice, pw.ImageProvider logo) =>
      pw.Wrap(
          alignment: pw.WrapAlignment.center,
          crossAxisAlignment: pw.WrapCrossAlignment.center,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.only(left: 1, top: 1),
              child: pw.Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  pw.Text("${invoice.inv?.date}"),
                  pw.SizedBox(
                    width: 40,
                  ),
                  pw.Text("Invoice No ${invoice.inv?.id}"),
                ],
              ),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Column(
              children: [
                pw.Image(logo),
                pw.Text("${invoice.inv?.biller}",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.values[0],
                      fontSize: 22,
                    )),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Text("${invoice.customer?.address}",
                    style: pw.TextStyle(
                      fontSize: 15,
                    )),
                pw.Text("Tel: ${invoice.customer?.phone} ",
                    style: pw.TextStyle(
                      fontSize: 15,
                    )),
                pw.Text("VatNo: ${invoice.biller?.vatNo} ",
                    style: pw.TextStyle(
                      fontSize: 15,
                    )),
                pw.SizedBox(height: 10),
                pw.Text("Simple Tax Invoice",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 22,
                    )),
              ],
            ),
            pw.Row(
              children: [
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Text("Date: ${invoice.inv?.date} ",
                        style: pw.TextStyle(
                          fontSize: 15,
                        )),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Text("sl no: ${invoice.inv?.saleId} ",
                        style: pw.TextStyle(
                          fontSize: 15,
                        )),
                    pw.Text("Sale No/Ref: ${invoice.inv?.referenceNo} ",
                        style: pw.TextStyle(
                          fontSize: 15,
                        )),
                    pw.Text("Sales Associate: MUHAMMED MUHSIN",
                        style: pw.TextStyle(
                          fontSize: 15,
                        )),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Text("Customer: ${invoice.inv?.customer}",
                        style: pw.TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            buildItems(invoice),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Total",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15,
                    )),
                pw.Text("${invoice.defaultCurrency?.name} ${invoice.total}",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15,
                    ))
              ],
            ),
            pw.Divider(
              color: PdfColors.grey300,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Tax",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15,
                    )),
                pw.Text("${invoice.defaultCurrency?.name} ${invoice.totalTax}",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15,
                    ))
              ],
            ),
            pw.Divider(
              color: PdfColors.grey300,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Grand Total",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15,
                    )),
                pw.Text(
                    "${invoice.defaultCurrency?.name} ${invoice.grandTotal}",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15,
                    ))
              ],
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Divider(
              color: PdfColors.grey300,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "Paid by: ${invoice.inv?.paymentMethod}  ",
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                  maxLines: 2,
                ),
                pw.Text(
                    "Amount: ${invoice.defaultCurrency?.name} ${invoice.payments?[0].posPaid}",
                    style: pw.TextStyle(
                      fontSize: 15,
                    )),
                pw.Text(
                  "balance: ${invoice.payments?[0].posBalance}",
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
            pw.SizedBox(
              height: 40,
            ),
            // pw.Align(
            //   alignment: pw.Alignment.topLeft,
            //   child: pw.Text("Tax Summary",
            //       style: pw.TextStyle(
            //         fontWeight: pw.FontWeight.bold,
            //         fontSize: 22,
            //       )),
            // ),
            // pw.SizedBox(
            //   height: 10,
            // ),
            // buildInvoice(invoice),
            pw.Divider(),
            // buildTotal(invoice),
            buildFooter(invoice)
          ]);
  static pw.Widget buildItems(InvoiceResponse invoice) => pw.Column(
        children: [
          pw.Wrap(
              children: List<pw.Widget>.generate(invoice.rows.length, (int i) {
            return pw.Container(
              child: pw.Column(
                children: <pw.Widget>[
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("#${i + 1}: ${invoice.rows[i].productName}",
                            style: pw.TextStyle(
                              fontSize: 15,
                            )),
                        if (invoice.rows[i].tax != "") ...[
                          pw.Text(" ${invoice.rows[i].taxCode}",
                              style: pw.TextStyle(
                                fontSize: 15,
                              )),
                        ] else
                          ...[],
                      ]),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          "${invoice.rows[i].unitQuantity} x ${invoice.defaultCurrency?.name} ${invoice.rows[i].unitPrice}",
                          style: pw.TextStyle(
                            fontSize: 15,
                          )),
                      pw.Text(
                          "${invoice.defaultCurrency?.name} ${invoice.rows[i].subtotal}",
                          style: pw.TextStyle(
                            fontSize: 15,
                          ))
                    ],
                  ),
                  pw.Divider(
                    color: PdfColors.grey300,
                  ),
                ],
              ),
            );
          })),
        ],
      );
  static pw.Widget buildInvoice(InvoiceResponse invoice) {
    final headers = [
      'Name',
      'Code',
      'Qty',
      'Tax Excl',
      'Tax Amt',
    ];
    final data = invoice.rows.map((item) {
      // final total = item.unitPrice * item.quantity * (1 + item.vat);
      if (item.tax != "") {
        return [
          item.taxName,
          item.taxCode,
          '${item.unitQuantity}',
          ' ${item.unitPrice}',
          '${item.taxRate} %',
        ];
      } else {
        return [
          "",
          "",
          '${item.unitQuantity}',
          ' ${item.unitPrice}',
          "",
        ];
      }
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
      },
    );
  }

  static formatPrice(double price, InvoiceResponse invoice) =>
      '${invoice.defaultCurrency?.name} ${price.toStringAsFixed(2)}';
  static pw.Widget buildTotal(InvoiceResponse invoice) {
    final netTotal = invoice.rows
        .map((item) =>
            double.parse(item.unitPrice!) * double.parse(item.quantity!))
        .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.rows.first.taxRate;
    final vatPercent = 15;
    final vat = netTotal * vatPercent;
    final total = netTotal + vat;

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Row(
        children: [
          pw.Spacer(flex: 4),
          pw.SizedBox(
            height: 10,
          ),
          pw.Expanded(
            flex: 4,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Total Tax Amount',
                  titleStyle: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  value: formatPrice(total, invoice),
                  unite: true,
                ),
                pw.SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget buildFooter(InvoiceResponse invoice) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.center,
        verticalDirection: pw.VerticalDirection.up,
        children: [
          pw.SizedBox(height: 15 * PdfPageFormat.mm),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Container(
                height: 150,
                width: 150,
                child: pw.BarcodeWidget(
                    data: invoice.qrCodeString, barcode: pw.Barcode.qrCode())),
          ),
          pw.SizedBox(height: 1 * PdfPageFormat.mm),
        ],
      );

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
