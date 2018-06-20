import 'package:intl/intl.dart';

class DateUtil {
  final fullDateFormat = new DateFormat('dd/MMM/yyyy');
  final dayMonthFormat = new DateFormat('dd, MMM');
  final monthFormat = new DateFormat('MMM');

  String formatDate(DateTime date) {
    if (date == null) {
      return "<date>";
    }
    return fullDateFormat.format(date);
  }

  String formatToDayMonth(DateTime date) {
    if (date == null) {
      return "<date>";
    }
    return dayMonthFormat.format(date);
  }

  String getFormatedCurrentDate() {
    return fullDateFormat.format(new DateTime.now());
  }

  String formatToMonth(DateTime date) {
    if (date == null) {
      return "M";
    }
    return monthFormat.format(date);
  }

  String getDay(DateTime date) {
    if (date == null) {
      return "D";
    }
    return date.day.toString();
  }

  String getYear(DateTime date) {
    if (date == null) {
      return "<Year>";
    }
    return date.year.toString();
  }
}

DateUtil dateUtil = new DateUtil();
