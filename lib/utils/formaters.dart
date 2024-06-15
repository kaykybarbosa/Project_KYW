import 'package:intl/intl.dart';

abstract class Formatters {
  static final DateFormat _formatter = DateFormat("dd/MM/yyyy");
  static final DateFormat _formatterWithOptions = DateFormat("d 'de' MMM 'de' y 'às' HH:mm", 'pt_BR');

  /// Retorna um dataTime no formato: dd/mm/yyyy
  static String formatDate(DateTime date) => _formatter.format(date);

  static DateTime? tryParseDate(String date, {bool dateDefault = false}) =>
      dateDefault ? DateTime.tryParse(date) : _formatter.tryParseUtc(date);

  static String formatDateHours(DateTime date) => DateFormat("HH:mm").format(date);

  /// Retorna a data no formato: d 'de' MMM 'de' y 'às' HH:mm
  static String formatDateWithOptions(DateTime date) => _formatterWithOptions.format(date);
}
