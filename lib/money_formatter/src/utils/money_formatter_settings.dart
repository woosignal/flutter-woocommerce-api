import '/money_formatter/src/utils/compact_format_type.dart';

/// [MoneyFormatterSettings] instance.
///
/// This instance is used as a configurator for the [FlutterMoneyFormatter] instance.
/// You can change the output of [FlutterMoneyFormatter] through this instance.
class MoneyFormatterSettings {
  /// Init instance of [MoneyFormatterSettings]
  MoneyFormatterSettings(
      {this.symbol,
      this.thousandSeparator,
      this.decimalSeparator,
      this.symbolAndNumberSeparator,
      this.fractionDigits,
      this.compactFormatType}) {
    symbol = symbol ?? '\$';
    thousandSeparator = thousandSeparator ?? ',';
    decimalSeparator = decimalSeparator ?? '.';
    symbolAndNumberSeparator = symbolAndNumberSeparator ?? ' ';
    fractionDigits = fractionDigits ?? 2;
    compactFormatType = compactFormatType ?? CompactFormatType.short;
  }

  /// The [symbol] that will be used on formatted output, default value is $ (Dollar Sign)
  String? symbol;

  // The character that will be used as thousand separator on formatted output, default value is ',' (comma)
  String? thousandSeparator;

  /// The character that will be used as decimal separator on formatted output, default value is '.' (dot)
  String? decimalSeparator;

  /// The character that will be used as separator between the numbers and the symbol.
  String? symbolAndNumberSeparator;

  /// The fraction digits that will be used on formatted output, default value is 2.
  int? fractionDigits;

  /// Compact format type, for example using 'million' or 'M'
  CompactFormatType? compactFormatType;
}
