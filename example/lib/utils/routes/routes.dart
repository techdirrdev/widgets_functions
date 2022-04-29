import 'package:flutter/material.dart';
import 'package:widgets_functions_example/dashboard.dart';
import 'package:widgets_functions_example/textfield/textfield_example.dart';

class Routes {
  Routes._();

  static var dashboard = '/dashboard';
  static var textFieldExample = '/textFieldExample';

  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {
      dashboard: (context) => const Dashboard(),
      textFieldExample: (context) => const TextFieldExample(),
    };
  }
}
