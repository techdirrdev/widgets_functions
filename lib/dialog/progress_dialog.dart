import 'dart:async';
import 'package:flutter/material.dart';

abstract class _ProgressDialog {
  ///You can set widget of dialog using this function,
  ///even the dialog already pop up.
  ///Set it Null to change it as default CircularProgressIndicator that already you set before
  void setChild(Widget child);

  void setDismissible(bool dismissible);
}

///Simple progress dialog, use Dialog Widget to custom it
class ProgressDialog implements _ProgressDialog {
  ///The context
  final BuildContext context;

  ///The (optional) default progress widget that are displayed before message of the dialog,
  ///it will replaced when you use setChild, and it will restored if you `setChild(null)`.
  Widget? child;

  ///dialog dismiss when click outside
  bool dismissible;

  bool _show = false;

  bool get isShowed => _show;

  ProgressDialog(this.context, {this.child, this.dismissible = true});

  ///Show progress dialog
  void show() async {
    if (!_show) {
      _show = true;
      _showDialog();
    }
  }

  ///Dismiss progress dialog
  void dismiss() {
    if (_show) {
      _show = false;
      Navigator.pop(context);
    }
  }

  void _showDialog() {
    Timer(const Duration(), () {
      showDialog(
          context: context,
          barrierDismissible: dismissible,
          builder: (ctx) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 5,
              backgroundColor: Colors.white,
              child: child ??
                  const Padding(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 120, right: 120),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )),
            );
          });
    });
  }

  @override
  void setChild(Widget child) {
    this.child = child;
  }

  @override
  void setDismissible(bool dismissible) {
    this.dismissible = dismissible;
  }
}
