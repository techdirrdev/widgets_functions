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
  List<WFDropdownItem> _itemList = [];
  String _singleSelectedId = "";
  final List<String> _mutiSelectedIds = [];

  @override
  void initState() {
    super.initState();
    _generateItems();
  }

  _generateItems() {
    List<WFDropdownItem> list = [];
    for (int i = 1; i <= 20; i++) {
      list.add(WFDropdownItem(
          id: "$i",
          value: "Item $i",
          data: User(userId: "$i", userName: "User $i")));
    }
    setState(() {
      _itemList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dropdown Example"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              WFDropdown.singleSelection(
                  title: "Single Selection Dropdown",
                  labelText: "Single",
                  hintText: "Single Selection",
                  list: _itemList,
                  selectedId: _singleSelectedId,
                  onSingleItemListener: (selectedItem) {
                    setState(() {
                      _singleSelectedId = selectedItem.id;
                    });
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
                  list: _itemList,
                  selectedIds: _mutiSelectedIds,
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
        ),
      )),
    );
  }
}
