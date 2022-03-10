import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:widgets_functions/dropdown/wf_dropdown.dart';
import 'package:widgets_functions/dropdown/wf_dropdown_item.dart';
import 'package:widgets_functions/text_field/wf_text_field.dart';
import 'package:widgets_functions/widgets_functions.dart';
import 'package:widgets_functions_example/dropdown/dropdown_example.dart';
import 'package:widgets_functions_example/textfield/textfield_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  List<WFDropdownItem> itemList = [];
  String singleSelectedId = "";
  List<String> mutiSelectedIds = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();

    for (int i = 1; i <= 20; i++) {
      itemList.add(WFDropdownItem(
          id: "$i",
          value: "Item $i",
          data: User(userId: "$i", userName: "User $i")));
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await WidgetsFunctions.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: const Text('widgets_functions')),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                /*ElevatedButton(
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
                            builder: (context) => const DropdownExample(),
                          ));
                    },
                    child: const Text("Dropdown")),*/
                const WFTextField(labelText: "Value", hintText: "Value"),
                const SizedBox(
                  height: 20,
                ),
                WFDropdown.single(
                    title: "Single Selection Dropdown",
                    labelText: "Single",
                    hintText: "Single Selection",
                    list: itemList,
                    selectedId: singleSelectedId,
                    onSingleItemListener: (selectedItem) {
                      String itemId = selectedItem.id;
                      String itemName = selectedItem.value;
                      User user = selectedItem.data;
                      print(
                          "Item Id: $itemId -- Item Name: $itemName ## Other Details ## User Id: ${user.userId} -- User Name: ${user.userName}");
                    }),
                const SizedBox(
                  height: 20,
                ),
                WFDropdown.multiple(
                    title: "Multi Selection Dropdown",
                    labelText: "Multi",
                    hintText: "Multi Selection",
                    list: itemList,
                    selectedIds: mutiSelectedIds,
                    allSelection: true,
                    onMultipleItemListener: (selectedItemList) {
                      for (WFDropdownItem selectedItem in selectedItemList) {
                        String itemId = selectedItem.id;
                        String itemName = selectedItem.value;
                        User user = selectedItem.data;
                        print(
                            "Item Id: $itemId -- Item Name: $itemName ## Other Details ## User Id: ${user.userId} -- User Name: ${user.userName}");
                      }
                    })
              ],
            ),
          ))),
    );
  }
}

class User {
  String userId;
  String userName;

  User({this.userId = "0", this.userName = ""});
}
