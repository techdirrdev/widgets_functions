import 'package:flutter/material.dart';
import 'package:widgets_functions_example/date_picker/date_picker_example.dart';
import 'package:widgets_functions_example/dropdown/dropdown_example.dart';
import 'package:widgets_functions_example/textfield/textfield_example.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TextFieldExample(),
                          ));
                    },
                    child: const Text("TextField")),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DatePickerExample(),
                          ));
                    },
                    child: const Text("Date Picker")),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DropdownExample(),
                          ));
                    },
                    child: const Text("Dropdown")),
              ],
            ),
          ),
        )));
  }
}
