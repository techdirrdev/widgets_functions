import 'package:flutter/material.dart';
import 'package:widgets_functions/navigator/result.dart';

class NavigateWithName {
  NavigateWithName._();

  static getArguments(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments;
  }

  static to(BuildContext context, String routeName,
      {dynamic arguments, Function(Result result)? result}) {
    Navigator.pushNamed(context, routeName, arguments: arguments).then((res) {
      if (res != null) {
        result!(res as Result);
      }
    });
  }

  static toFinish(BuildContext context, String routeName, {dynamic arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static replace(BuildContext context, String routeName, {dynamic arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static toFinishUntil(
      BuildContext context, String routeName, String untilRouteName,
      {dynamic arguments}) {
    Navigator.pushNamedAndRemoveUntil(
        context, routeName, ModalRoute.withName(untilRouteName),
        arguments: arguments);
  }

  static finish(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }
}
