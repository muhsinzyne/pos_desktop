import 'package:posdelivery/models/constants.dart';

class StringHelper {
  static splitFromBracket(String stringValue) {
    final start = Constants.stringExpressionStart;
    final end = Constants.stringExpressionStop;
    final startIndex = stringValue.indexOf(start);
    final endIndex = stringValue.indexOf(end);
    final result = stringValue.substring(startIndex + start.length, endIndex).trim();
    return result;
  }
}
