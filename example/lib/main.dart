import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:widgets_functions/dropdown/wf_dropdown.dart';
import 'package:widgets_functions/dropdown/wf_dropdown_item.dart';
import 'package:widgets_functions/text_field/wf_text_field.dart';
import 'package:widgets_functions_example/model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<WFDropdownItem> itemList = [];
  String singleSelectedId = "";
  List<String> mutiSelectedIds = [];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 20; i++) {
      itemList.add(WFDropdownItem(
          id: "$i",
          value: "Item $i",
          data: User(userId: "$i", userName: "User $i")));
    }
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
                      log("Item Id: $itemId -- Item Name: $itemName ## Other Details ## User Id: ${user.userId} -- User Name: ${user.userName}");
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
                        log("Item Id: $itemId -- Item Name: $itemName ## Other Details ## User Id: ${user.userId} -- User Name: ${user.userName}");
                      }
                    })
              ],
            ),
          ))),
    );
  }
}
