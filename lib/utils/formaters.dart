import 'package:intl/intl.dart';

abstract class Formaters {
  static final DateFormat _formatter = DateFormat("dd/MM/yyyy");

  static String formatDate(DateTime date) => _formatter.format(date);
}
