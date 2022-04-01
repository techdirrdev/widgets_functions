import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widgets_functions/utils.dart';

class DateTimes {
  static const String _am = "am";
  static const String _pm = "pm";
  static const String fyyyyMMdd = "yyyy-MM-dd";
  static const String fyyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss";
  static const String fyyyy = "yyyy";
  static const String fHHmmss = "HH:mm:ss";
  static const String fhhmmpp = "hh:mm am";
  static const String fHHmm = "HH:mm";

  static String getCurrentDateTime({String format = DateTimes.fyyyyMMdd}) {
    return DateFormat(format).format(DateTime.now());
  }

  static String getCurrentTime({String format = DateTimes.fHHmmss}) {
    return DateTimes.timeToString(time: TimeOfDay.now(), format: format);
  }

  static datePicker(
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
          ? DateTimes.dateTimeToString(date: value, format: format)
          : (Utils.isNullOrEmpty(date)
              ? ""
              : DateTimes.dateTimeToString(
                  date: DateTimes.stringToDateTime(date: date!, format: format),
                  format: format)));
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

  static timePicker(
      {required BuildContext context,
      required Function(String time) dateTime,
      String? time,
      String? minTime,
      String? maxTime,
      String format = DateTimes.fyyyyMMdd}) {
    showTimePicker(
            context: context, initialTime: DateTimes.stringToTime(time: time))
        .then((value) {
      dateTime((value != null)
          ? DateTimes.timeToString(time: value)
          : (Utils.isNullOrEmpty(time) ? "" : time.toString()));
    });
  }

  static TimeOfDay stringToTime({required String? time}) {
    if (Utils.isNullOrEmpty(time)) {
      return TimeOfDay.now();
    } else {
      int hour = TimeOfDay.now().hour;
      int minute = TimeOfDay.now().minute;
      if (time!.toLowerCase().contains(DateTimes._am) ||
          time.toLowerCase().contains(DateTimes._pm)) {
        if (time.toLowerCase().contains(DateTimes._pm)) {
          hour = (int.parse((time.split(' ')[0]).split(':')[0])) + 12;
        } else {
          hour = (int.parse((time.split(' ')[0]).split(':')[0]));
        }
        minute = int.parse((time.split(' ')[0]).split(':')[1]);
      } else {
        hour = int.parse((time.split(' ')[0]).split(':')[0]);
        minute = int.parse((time.split(' ')[0]).split(':')[1]);
      }
      return TimeOfDay(hour: hour, minute: minute);
    }
  }

  static String timeToString(
      {required TimeOfDay time, String format = DateTimes.fHHmmss}) {
    int hour = time.hour;
    String hourWithLeadingZero = DateTimes._timeWithLeadingZero(hour);
    String minuteWithLeadingZero = DateTimes._timeWithLeadingZero(time.minute);

    if (Utils.equals(format, DateTimes.fHHmmss)) {
      return "$hourWithLeadingZero:$minuteWithLeadingZero:00";
    } else if (Utils.equals(format, DateTimes.fHHmm)) {
      return "$hourWithLeadingZero:$minuteWithLeadingZero";
    } else if (Utils.equals(format, DateTimes.fhhmmpp)) {
      if (hour > 12) {
        hour -= 12;
        hourWithLeadingZero = DateTimes._timeWithLeadingZero(hour);
      }
      if (hour == 0) {
        hour = 12;
        hourWithLeadingZero = DateTimes._timeWithLeadingZero(hour);
      }
      return "$hourWithLeadingZero:$minuteWithLeadingZero ${time.period.name.toUpperCase()}";
    } else {
      return "";
    }
  }

  static String _timeWithLeadingZero(int value) {
    if (value.toString().length < 2) {
      return "0$value";
    } else {
      return value.toString();
    }
  }

  static String periodTime(
      {required String time, String format = DateTimes.fhhmmpp}) {
    if (Utils.isNullOrEmpty(time)) {
      return "";
    } else {
      return DateTimes.timeToString(
          time: DateTimes.stringToTime(time: time), format: format);
    }
  }
}
