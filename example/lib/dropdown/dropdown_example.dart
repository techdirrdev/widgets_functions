import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:widgets_functions/dropdown/wf_dropdown.dart';
import 'package:widgets_functions/dropdown/wf_dropdown_item.dart';
import 'package:widgets_functions_example/model/user.dart';

class DropdownExample extends StatefulWidget {
  const DropdownExample({Key? key}) : super(key: key);

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dropdown Example"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          WFDropdown.singleSelection(
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
          WFDropdown.multiSelection(
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
      )),
    );
  }
}
