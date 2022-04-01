import 'package:flutter/material.dart';
import 'package:widgets_functions_example/dashboard.dart';
import 'package:widgets_functions_example/date_time_picker/date_time_picker_example.dart';
import 'package:widgets_functions_example/dropdown/dropdown_example.dart';
import 'package:widgets_functions_example/textfield/textfield_example.dart';

class Routes {
  Routes._();

  static var dashboard = '/dashboard';
  static var textFieldExample = '/textFieldExample';
  static var datePickerExample = '/datePickerExample';
  static var dropdownExample = '/dropdownExample';

  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {
      dashboard: (context) => const Dashboard(),
      textFieldExample: (context) => const TextFieldExample(),
      datePickerExample: (context) => const DateTimePickerExample(),
      dropdownExample: (context) => const DropdownExample(),
    };
  }
}
