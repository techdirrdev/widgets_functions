import 'dart:async';

import 'package:flutter/material.dart';
import 'package:route_navigator/navigate.dart';
import 'package:widgets_functions/dialog/progress_dialog.dart';
import 'package:widgets_functions/responsive/responsive_widget.dart';
import 'package:widgets_functions_example/utils/routes/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ProgressDialog? _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
    _dialog?.show();
    Timer(const Duration(seconds: 2), () {
      _dialog?.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        mobileBody: _mbDashboard(context),
        tabletBody: _mbDashboard(context),
        desktopBody: _mbDashboard(context));
  }

  _mbDashboard(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('widgets_functions')),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    onPressed: () {
                      NavigateWithName.to(context, Routes.textFieldExample);
                    },
                    child: const Text("TextField"))
              ],
            ),
          ),
        )));
  }
}
