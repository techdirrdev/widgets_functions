import 'package:flutter/material.dart';
import 'package:widgets_functions/text_field/wf_text_field.dart';

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({Key? key}) : super(key: key);

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TextField Example"),),
      body: SafeArea(child: Column(children: const [
        WFTextField(labelText: "Value", hintText: "Value"),
      ],)),
    );
  }
}
