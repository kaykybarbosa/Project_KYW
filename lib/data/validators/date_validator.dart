class DateValidator {
  static bool validateDate(String dateTime) {
    DateTime? date;

    try {
      // first step
      date = DateTime.tryParse(dateTime);
      if (date == null) {
        return false;
      }

      //secound step
      DateTime now = DateTime.now();
      DateTime firstDate = DateTime(now.year - 2, now.month, now.day);

      if (date.isBefore(firstDate)) {
        return false;
      }
      if (date.isAfter(now)) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
