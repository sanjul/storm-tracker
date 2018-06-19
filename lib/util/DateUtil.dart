import 'package:intl/intl.dart';

class DateUtil {
  final formatter = new DateFormat('dd/MMM/yyyy');
  final monthFormatter = new DateFormat('MMM');

  String formatDate(DateTime date) {
    if (date == null) {
      return "<date>";
    }
    return formatter.format(date);
  }

  String getFormatedCurrentDate() {
    return formatter.format(new DateTime.now());
  }

  String formatToMonth(DateTime date) {
    if (date == null) {
      return "M";
    }
    return monthFormatter.format(date);
  }

  String getDay(DateTime date) {
    if (date == null) {
      return "D";
    }
    return date.day.toString();
  }

  String getYear(DateTime date) {
    if (date == null) {
      return "YYYY";
    }
    return date.year.toString();
  }
}

DateUtil dateUtil = new DateUtil();
