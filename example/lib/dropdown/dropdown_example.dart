import 'package:flutter/material.dart';

class DropdownExample extends StatefulWidget {
  const DropdownExample({Key? key}) : super(key: key);

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dropdown Example"),),
      body: SafeArea(child: Column(children: [

      ],)),
    );
  }
}
