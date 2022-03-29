import 'package:flutter/material.dart';
import 'package:widgets_functions/keyboard/keyboard_dismiss.dart';
import 'package:widgets_functions_example/dashboard.dart';
import 'package:widgets_functions_example/utils/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismiss(
      onTapDismiss: true,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: Routes.routes(context),
          home: const Dashboard()),
    );
  }
}
