import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    double corrected = number * 1000;
    final formatted = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(corrected);

    return formatted;
  }

  static String numberDecimal(double number, {int decimals = 1}) {
    final formatter = NumberFormat.decimalPattern('en');
    formatter.minimumFractionDigits = decimals;
    formatter.maximumFractionDigits = decimals;
    return formatter.format(number);
  }
}
