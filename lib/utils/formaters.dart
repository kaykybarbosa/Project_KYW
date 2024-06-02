import 'package:intl/intl.dart';

abstract class Formaters {
  static final DateFormat _formatter = DateFormat("dd/MM/yyyy");

  /// Retorna um dataTime no formato: dd/mm/yyyy
  static String formatDate(DateTime date) => _formatter.format(date);

  static String formatDateHours(DateTime date) => DateFormat("HH:mm").format(date);
}
