import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widgets_functions/utils.dart';

class DateTimes {
  static const String _am = "am";
  static const String _pm = "pm";
  static const String fyyyyMMdd = "yyyy-MM-dd";
  static const String fyyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss";
  static const String fyyyy = "yyyy";
  static const String fE = "E";
  static const String fEE = "EE";
  static const String fhhmmpp = "hh:mm am";
  static const String fhhmm = "hh:mm";

  static String getCurrentDateTime({String format = DateTimes.fyyyyMMdd}) {
    return DateFormat(format).format(DateTime.now());
  }

  static String getCurrentTime({String format = DateTimes.fhhmm}) {
    return DateTimes.timeToString(time: TimeOfDay.now());
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
      print(value!.hour);
      print(value.minute);
      print(value.period.name);
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
      {required TimeOfDay time, String format = DateTimes.fhhmm}) {
    print("len: ${(time.hour.toString().length)}");
    if (Utils.equals(format, DateTimes.fhhmm)) {
      return "${(time.hour)}:${time.minute}";
    } else if (Utils.equals(format, DateTimes.fhhmmpp)) {
      if (Utils.equals(time.period.name.toUpperCase(), DateTimes._pm)) {
        return "${time.hour - 12}:${time.minute} ${time.period.name.toUpperCase()}";
      }
      else {
        return "${time.hour}:${time.minute} ${time.period.name.toUpperCase()}";
      }
    } else {
      return "";
    }
  }

  static String periodTime(
      {required String time, String format = DateTimes.fhhmmpp}) {
    return DateTimes.timeToString(
        time: DateTimes.stringToTime(time: time), format: format);
  }
}
