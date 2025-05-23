part of '../flutter_money_formatter_base.dart';

enum FastCalcType {
  addition,
  substraction,
  multiplication,
  division,
  percentageAddition,
  percentageSubstraction
}

class _Utilities {
  _Utilities({required this.amount, this.settings}) {
    settings = settings ?? MoneyFormatterSettings();
  }

  final double amount;

  MoneyFormatterSettings? settings;

  /// Returns formatted number
  String get baseFormat => NumberFormat.currency(
          symbol: '', decimalDigits: settings?.fractionDigits, locale: 'en_US')
      .format(amount);

  /// Returns formatted number with refined separator chars
  String get refineSeparator => baseFormat
      .replaceAll(',', '(,)')
      .replaceAll('.', '(.)')
      .replaceAll('(,)', settings?.thousandSeparator ?? ' ')
      .replaceAll('(.)', settings?.decimalSeparator ?? ' ');

  /// Returns spacer as `spaceBetweenSymbolAndNumber` value
  String get spacer => settings?.symbolAndNumberSeparator ?? ' ';

  /// Returns base compact format
  NumberFormat get baseCompact =>
      settings?.compactFormatType == CompactFormatType.short
          ? NumberFormat.compact()
          : NumberFormat.compactLong();
}
