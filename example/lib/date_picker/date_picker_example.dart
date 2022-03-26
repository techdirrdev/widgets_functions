import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:widgets_functions/date_time/date_times.dart';
import 'package:widgets_functions/responsive/responsive_widget.dart';
import 'package:widgets_functions/text_field/wf_text_field.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({Key? key}) : super(key: key);

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  String _selectedDate = DateTimes.getCurrentDateTime();
  final TextEditingController _conDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        mobileBody: _mbDatePickerExample(context),
        tabletBody: _mbDatePickerExample(context),
        desktopBody: _mbDatePickerExample(context));
  }

  _mbDatePickerExample(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date Picker Example"),
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
              )
            ],
          ),
        ),
      )),
    );
  }
}
