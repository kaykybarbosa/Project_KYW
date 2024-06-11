import 'package:intl/intl.dart';

abstract class Formatters {
  static final DateFormat _formatter = DateFormat("dd/MM/yyyy");

  /// Retorna um dataTime no formato: dd/mm/yyyy
  static String formatDate(DateTime date) => _formatter.format(date);

  static DateTime? tryParseDate(String date, {bool dateDefault = false}) =>
      dateDefault ? DateTime.tryParse(date) : _formatter.tryParseUtc(date);

  static String formatDateHours(DateTime date) => DateFormat("HH:mm").format(date);
}
