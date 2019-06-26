class DateTimeHelper {
  static DateTime getDate (DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}