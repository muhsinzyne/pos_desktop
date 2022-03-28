import 'package:intl/intl.dart';

class CurrencyFormat {
  String? format;
  String? symbol;
  NumberFormat? instance;
  String? decimal;
  CurrencyFormat(
      {this.format = '##,##,###', this.symbol = 'SR', this.decimal = '00'}) {
    instance = NumberFormat("$format.$decimal", "ar_SA");
  }

  String formatCurrency(double value) {
    var data = instance!.format(value);
    return symbol! + ' ' + data.toString();
  }

  String formatToNumber(double value) {
    var data = instance!.format(value);
    return data.toString();
  }
}
