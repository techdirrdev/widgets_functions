import 'package:flutter/material.dart';

/// [ResponsiveWidget] provide responsive layout
class ResponsiveWidget extends StatelessWidget {
  /// size (px) ...-600
  final Widget mobileBody;

  /// size (px) 600-1200
  final Widget tabletBody;

  /// size (px) 600-...
  final Widget desktopBody;

  const ResponsiveWidget(
      {Key? key,
      required this.mobileBody,
      required this.tabletBody,
      required this.desktopBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return mobileBody;
      } else if (constraints.maxWidth > 1200) {
        return desktopBody;
      } else {
        return tabletBody;
      }
    });
  }
}
