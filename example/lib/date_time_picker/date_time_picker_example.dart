import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:widgets_functions/date_time/date_times.dart';
import 'package:widgets_functions/responsive/responsive_widget.dart';
import 'package:widgets_functions/text_field/wf_text_field.dart';

class DateTimePickerExample extends StatefulWidget {
  const DateTimePickerExample({Key? key}) : super(key: key);

  @override
  State<DateTimePickerExample> createState() => _DateTimePickerExampleState();
}

class _DateTimePickerExampleState extends State<DateTimePickerExample> {
  String _selectedDate = DateTimes.getCurrentDateTime();
  String _selectedTime = DateTimes.getCurrentTime();
  final TextEditingController _conDate = TextEditingController();
  final TextEditingController _conTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        mobileBody: _mbDateTimePickerExample(context),
        tabletBody: _mbDateTimePickerExample(context),
        desktopBody: _mbDateTimePickerExample(context));
  }

  _mbDateTimePickerExample(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date & Time Picker Example"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              WFTextField(
                controller: _conDate
                  ..text = DateTimes.reverseDate(date: _selectedDate),
                labelText: "Date",
                hintText: "Select Date",
                readOnly: true,
                onTap: () {
                  DateTimes.datePicker(
                      context: context,
                      date: _selectedDate,
                      dateTime: (date) {
                        log(date);
                        setState(() {
                          _selectedDate = date;
                        });
                      });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              WFTextField(
                controller: _conTime
                  ..text = DateTimes.periodTime(time: _selectedTime),
                labelText: "Time",
                hintText: "Select Time",
                readOnly: true,
                onTap: () {
                  DateTimes.timePicker(
                      context: context,
                      time: _selectedTime,
                      dateTime: (time) {
                        log(time);
                        setState(() {
                          _selectedTime = time;
                        });
                      });
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
