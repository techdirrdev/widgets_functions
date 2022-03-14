import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widgets_functions/utils.dart';

class DateTimes {
  DateTimes._();

  static const String fyyyyMMdd = "yyyy-MM-dd";
  static const String fyyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss";
  static const String fyyyy = "yyyy";
  static const String fE = "E";
  static const String fEE = "EE";

  static String getCurrentDateTime({String format = DateTimes.fyyyyMMdd}) {
    return DateFormat(format).format(DateTime.now());
  }

  static dateSelection(
      {required BuildContext context,
      required Function(String date) dateTime,
      String? date,
      String? minDate,
      String? maxDate,
      String format = DateTimes.fyyyyMMdd}) {
    showDatePicker(
      context: context,
      initialDate: Utils.isNullOrEmpty(date)
          ? DateTime.now()
          : DateTimes.stringToDateTime(date: date!, format: format),
      firstDate: Utils.isNullOrEmpty(minDate)
          ? DateTime(1950)
          : DateTimes.stringToDateTime(date: minDate!, format: format),
      lastDate: Utils.isNullOrEmpty(maxDate)
          ? DateTime(3000)
          : DateTimes.stringToDateTime(date: maxDate!, format: format),
    ).then((value) {
      dateTime((value != null)
          ? DateTimes.dateTimeToString(date: value)
          : (Utils.isNullOrEmpty(date) ? "" : date.toString()));
    });
  }

  static DateTime stringToDateTime(
      {required String date, String format = DateTimes.fyyyyMMdd}) {
    if (Utils.isNullOrEmpty(date)) {
      return DateTime.now();
    } else {
      return DateTime.parse(DateFormat(format).format(DateTime.parse(date)));
    }
  }

  static String dateTimeToString(
      {required DateTime date, String format = DateTimes.fyyyyMMdd}) {
    return DateFormat(format).format(date);
  }

  static bool validDateRange(
      {required String fromDate, required String toDate}) {
    if ((DateTimes.stringToDateTime(date: fromDate))
        .isBefore((DateTimes.stringToDateTime(date: toDate)))) {
      return true;
    } else {
      return false;
    }
  }

  static String setValidDate(
      {required String fromDate, required String toDate}) {
    if (DateTimes.validDateRange(fromDate: fromDate, toDate: toDate)) {
      return toDate;
    } else {
      return fromDate;
    }
  }

  static String reverseDate(
      {required String date, String dateFormat = DateTimes.fyyyyMMdd}) {
    String reverseDate = "";
    if (Utils.equals(dateFormat, DateTimes.fyyyyMMdd, ignoreCase: false) &&
        !Utils.isNullOrEmpty(date)) {
      var dateArray = date.split("-").toList();
      if (dateArray.length == 3) {
        reverseDate = "${dateArray[2]}-${dateArray[1]}-${dateArray[0]}";
      }
    }
    return reverseDate;
  }
}
