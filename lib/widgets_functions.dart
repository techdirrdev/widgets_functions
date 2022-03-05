
import 'dart:async';

import 'package:flutter/services.dart';

class WidgetsFunctions {
  static const MethodChannel _channel = MethodChannel('widgets_functions');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
