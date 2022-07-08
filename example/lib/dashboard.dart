import 'dart:async';

import 'package:flutter/material.dart';
import 'package:route_navigator/navigate.dart';
import 'package:widgets_functions/dialog/progress_dialog.dart';
import 'package:widgets_functions/responsive/responsive_layout.dart';
import 'package:widgets_functions_example/utils/routes/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late ProgressDialog _dialog;

  @override
  void initState() {
    super.initState();
    _dialog = ProgressDialog(context);
    _dialog.show();
    Timer(const Duration(seconds: 5), () {
      _dialog.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: _mbDashboard(context),
        tabletBody: _tbDashboard(context),
        desktopBody: _dbDashboard(context));
  }

  _mbDashboard(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(title: const Text('widgets_functions')),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Responsive Mobile Body"),
              const SizedBox(height: 20),
              _widgets(context)
            ],
          ),
        )));
  }

  _tbDashboard(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        appBar: AppBar(title: const Text('widgets_functions')),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Responsive Tablet Body"),
              const SizedBox(height: 20),
              _widgets(context)
            ],
          ),
        )));
  }

  _dbDashboard(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(title: const Text('widgets_functions')),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Responsive Desktop Body"),
              const SizedBox(height: 20),
              _widgets(context)
            ],
          ),
        )));
  }

  _widgets(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
