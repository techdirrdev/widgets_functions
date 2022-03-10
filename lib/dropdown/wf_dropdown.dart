import 'package:flutter/material.dart';
import 'package:widgets_functions/dropdown/wf_dropdown_item.dart';

const String _ok = "OK";
const String _cancel = "Cancel";
const String _has = "#";
const String _comma = ",";
const String _searchHere = "Search here...";
const IconData _icSearch = Icons.search;

// Dropdown for single selection or multi selection
class WFDropdown extends StatefulWidget {
  // dropdown item list
  List<WFDropdownItem> list = [];

  // selected item id for single dropdown
  String? selectedId;

  // selected item id list for multiple dropdown
  List<String>? selectedIds;

  // dropdown dialog title
  String title = "";

  // dropdown label text
  String labelText = "";

  // dropdown hint text
  String hintText = "";

  // dropdown enable or not
  bool enabled = true;

  // dropdown border
  InputBorder border = const OutlineInputBorder();

  // dropdown selected item prefix separator for multiple dropdown
  String prefixSeparator = _has;

  // dropdown selected item suffix separator for multiple dropdown
  String suffixSeparator = _comma;

  // dropdown selected item background color
  Color selectedBackgroundColor = Colors.black12;

  // dropdown dialog item search box visible or not
  bool searchBox = true;

  // dropdown dialog item search box hint text
  String searchBoxHintText = _searchHere;

  // dropdown dialog item search box prefix icon
  IconData prefixSearchBoxIcon = _icSearch;

  // dropdown dialog negative button text
  String negativeButtonText = _cancel;

  // dropdown dialog positive button text for multiple dropdown
  String positiveButtonText = _ok;

  // dropdown dialog negative button text color
  Color negativeButtonTextColor = Colors.red;

  // dropdown dialog positive button text color for multiple dropdown
  Color positiveButtonTextColor = Colors.black;

  // dropdown dialog all selection button visible or not for multiple dropdown
  bool allSelection = false;

  // dropdown item check box active color for multiple dropdown
  Color checkBoxActiveColor = Colors.black;

  // dropdown single selection listener function
  Function(WFDropdownItem selectedItem)? onSingleItemListener;

  // dropdown multi selection listener function
  Function(List<WFDropdownItem> selectedItemList)? onMultipleItemListener;

  // dropdown single or multiple
  bool _isMultiple = false;

  // constructor for single selection dropdown
  WFDropdown.single(
      {Key? key,
      required this.list,
      required this.onSingleItemListener,
      this.selectedId,
      this.title = "",
      this.labelText = "",
      this.hintText = "",
      this.enabled = true,
      this.border = const OutlineInputBorder(),
      this.searchBox = true,
      this.searchBoxHintText = _searchHere,
      this.prefixSearchBoxIcon = _icSearch,
      this.selectedBackgroundColor = Colors.black12,
      this.negativeButtonText = _cancel,
      this.negativeButtonTextColor = Colors.red}) {
    _isMultiple = false;
    selectedId = selectedId ?? "";
    selectedIds = selectedIds ?? [];
  }

  // constructor for single multi dropdown
  WFDropdown.multiple(
      {Key? key,
      required this.list,
      required this.onMultipleItemListener,
      this.selectedIds,
      this.title = "",
      this.labelText = "",
      this.hintText = "",
      this.enabled = true,
      this.border = const OutlineInputBorder(),
      this.searchBox = true,
      this.prefixSeparator = _has,
      this.suffixSeparator = _comma,
      this.searchBoxHintText = _searchHere,
      this.prefixSearchBoxIcon = _icSearch,
      this.selectedBackgroundColor = Colors.black12,
      this.negativeButtonText = _cancel,
      this.positiveButtonText = _ok,
      this.negativeButtonTextColor = Colors.red,
      this.positiveButtonTextColor = Colors.black,
      this.allSelection = false,
      this.checkBoxActiveColor = Colors.black}) {
    _isMultiple = true;
    selectedId = selectedId ?? "";
    selectedIds = selectedIds ?? [];
  }

  @override
  State<WFDropdown> createState() => _WFDropdownState();
}

class _WFDropdownState extends State<WFDropdown> {
  final TextEditingController _conSelectedValue = TextEditingController();
  final TextEditingController _conSearchBox = TextEditingController();
  bool _isAllSelected = false;

  @override
  void initState() {
    super.initState();
    _initialSetup();
  }

  // initial setup of dropdown item selection
  _initialSetup() {
    print(widget.list.length);
    String selectedValue = _getSelectedValue(list: widget.list);
    _conSelectedValue.text = selectedValue;
  }

  // get selected value from dropdown item list
  String _getSelectedValue({required List<WFDropdownItem> list}) {
    String id = "";
    String value = widget.hintText;
    if (widget._isMultiple) {
      for (String selectedId in widget.selectedIds!) {
        for (WFDropdownItem obj in widget.list) {
          if (obj.id.toLowerCase() == (selectedId).toLowerCase()) {
            if (id.isEmpty) {
              id = "${obj.id}$_comma";
              value = "${widget.prefixSeparator}${obj.value}";
            } else {
              id = "$id, ${obj.id}";
              value =
                  "$value${widget.suffixSeparator} ${widget.prefixSeparator}${obj.value}";
            }
          }
        }
      }
    } else {
      for (WFDropdownItem obj in widget.list) {
        if (obj.id.toLowerCase() == (widget.selectedId!).toLowerCase()) {
          value = obj.value;
          break;
        }
      }
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        _openDropdown(
            context: context,
            list: widget.list,
            isMultiple: widget._isMultiple,
            title: ((widget.title.trim()).isNotEmpty)
                ? widget.title
                : widget.labelText);
      },
      controller: _conSelectedValue,
      readOnly: true,
      enabled: widget.enabled,
      decoration: InputDecoration(
          suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
          border: widget.border,
          labelText: widget.labelText,
          hintText: widget.hintText),
    );
  }

  // check selected dropdown item
  _checkAllSelection(List<WFDropdownItem> list) {
    if (widget.allSelection) {
      int selectedItemCount = 0;
      for (WFDropdownItem obj in list) {
        if (obj.selected) {
          selectedItemCount++;
        }
      }
      if (selectedItemCount == list.length) {
        _isAllSelected = true;
      } else {
        _isAllSelected = false;
      }
      setState(() {});
    }
  }

  // open dropdown dialog
  _openDropdown(
      {required BuildContext context,
      required List<WFDropdownItem> list,
      required bool isMultiple,
      String title = ""}) {
    for (WFDropdownItem obj in list) {
      obj.selected = false;
    }
    if (isMultiple) {
      for (String selectedId in widget.selectedIds!) {
        for (WFDropdownItem obj in list) {
          if (obj.id.toLowerCase() == (selectedId).toLowerCase()) {
            obj.selected = true;
          }
        }
      }
    } else {
      for (WFDropdownItem obj in list) {
        if (obj.id.toLowerCase() == (widget.selectedId!).toLowerCase()) {
          obj.selected = true;
          break;
        }
      }
    }

    List<WFDropdownItem> _fList = WFDropdownItem.cloneList(list);
    _conSearchBox.clear();
    _checkAllSelection(list);

    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (buildContext, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Visibility(
                      visible: (title.trim().isNotEmpty),
                      child: Column(
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: widget.searchBox || widget.allSelection,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: widget.searchBox,
                                child: Expanded(
                                  child: TextFormField(
                                    controller: _conSearchBox,
                                    decoration: InputDecoration(
                                        hintText: widget.searchBoxHintText,
                                        prefixIcon:
                                            Icon(widget.prefixSearchBoxIcon)),
                                    onChanged: (value) {
                                      _fList.clear();
                                      if ((value.trim()).isNotEmpty) {
                                        for (WFDropdownItem obj in list) {
                                          if (obj.value
                                              .toLowerCase()
                                              .contains(value.toLowerCase())) {
                                            _fList.add(obj);
                                          }
                                        }
                                      } else {
                                        _fList = WFDropdownItem.cloneList(list);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.allSelection,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          _isAllSelected = !_isAllSelected;
                                          for (WFDropdownItem obj in list) {
                                            obj.selected = _isAllSelected;
                                          }
                                          setState(() {});
                                        },
                                        child: Icon(_isAllSelected
                                            ? Icons.playlist_add_check_rounded
                                            : Icons.subject))
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Visibility(
                        visible: _fList.isNotEmpty,
                        replacement: const Center(child: Text("No data")),
                        child: ListView.builder(
                          key: const PageStorageKey<String>('list'),
                          shrinkWrap: true,
                          itemCount: _fList.length,
                          itemBuilder: (context, index) {
                            return _dropdownItemView(context, isMultiple,
                                _fList[index], _fList, setState);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              widget.negativeButtonText,
                              style: TextStyle(
                                  color: widget.negativeButtonTextColor),
                            )),
                        Visibility(
                          visible: isMultiple,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 5),
                              TextButton(
                                  onPressed: () {
                                    widget.selectedIds!.clear();
                                    List<WFDropdownItem> selectedList = [];
                                    for (WFDropdownItem selectedObj in list) {
                                      if (selectedObj.selected) {
                                        widget.selectedIds!.add(selectedObj.id);
                                        selectedList.add(selectedObj);
                                      }
                                    }
                                    String selectedValue =
                                        _getSelectedValue(list: selectedList);
                                    _conSelectedValue.text = selectedValue;
                                    if (widget.onMultipleItemListener != null) {
                                      widget.onMultipleItemListener!(
                                          selectedList);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    widget.positiveButtonText,
                                    style: TextStyle(
                                        color: widget.positiveButtonTextColor),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  // dropdown item view
  _dropdownItemView(BuildContext context, bool isMultiple, WFDropdownItem obj,
      List<WFDropdownItem> list, StateSetter setState) {
    return InkWell(
        onTap: () {
          if (isMultiple) {
            setState(() {
              obj.selected = !obj.selected;
            });
            _checkAllSelection(list);
          } else {
            widget.selectedId = obj.id;
            _conSelectedValue.text = obj.value;
            if (widget.onSingleItemListener != null) {
              widget.onSingleItemListener!(obj);
            }
            Navigator.pop(context);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2),
          padding: EdgeInsets.all(isMultiple ? 10 : 20),
          decoration: BoxDecoration(
              color:
                  obj.selected ? widget.selectedBackgroundColor : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Visibility(
                visible: isMultiple,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        activeColor: widget.checkBoxActiveColor,
                        value: obj.selected,
                        onChanged: (isChecked) {
                          setState(() {
                            obj.selected = !obj.selected;
                          });
                        }),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Expanded(child: Text(obj.value)),
            ],
          ),
        ));
  }
}
