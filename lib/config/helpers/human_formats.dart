import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, [int? decimalDigits]) {
    return NumberFormat.compactCurrency(
            decimalDigits: decimalDigits ?? 0, symbol: '', locale: 'en')
        .format(number);
  }
}
