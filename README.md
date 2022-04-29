# widgets_functions

Custom Widgets and Functions, Widgets and Function easy to access, reuse and no longer code.

## Using

For help getting started with Flutter, view our
[online documentation](https://pub.dev/documentation/widgets_functions/latest), which offers tutorials,
samples, guidance on mobile and web development, and a full API reference.

## Installation

First, add `widgets_functions` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

In your flutter project add the dependency:

```yml
dependencies:
  ...
  widgets_functions:
```

For help getting started with Flutter, view the online
[documentation](https://flutter.io/).

## Example

Please follow this [example](https://github.com/techdirrdev/widgets_functions/tree/master/example) here.


### Text Field

```dart
WFTextField(labelText: "Value", hintText: "Value")
```


### Date Picker and Time Picker

1. Declare variables
```dart
String _selectedDate = DateTimes.getCurrentDateTime();
String _selectedTime = DateTimes.getCurrentTime();
final TextEditingController _conDate = TextEditingController();
final TextEditingController _conTime = TextEditingController();
```

2. Put DateTimes.datePicker or DateTimes.timePicker in your build function

* Date Picker
```dart
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
```

* Time Picker
```dart
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
```

