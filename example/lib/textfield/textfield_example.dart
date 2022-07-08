import 'package:flutter/material.dart';
import 'package:widgets_functions/responsive/responsive_layout.dart';
import 'package:widgets_functions/text_field/wf_text_field.dart';

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({Key? key}) : super(key: key);

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: _mbTextFieldExample(context),
        tabletBody: _mbTextFieldExample(context),
        desktopBody: _mbTextFieldExample(context));
  }

  _mbTextFieldExample(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField Example"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const [
              WFTextField(labelText: "Value", hintText: "Value"),
            ],
          ),
        ),
      )),
    );
  }
}
