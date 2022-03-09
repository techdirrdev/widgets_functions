import 'package:flutter/material.dart';
import 'package:widgets_functions/dropdown/wf_dropdown_item.dart';

const String _ok = "OK";
const String _cancel = "Cancel";
const String _has = "#";
const String _comma = ",";
const String _searchHere = "Search here...";
const IconData _icSearch = Icons.search;

class WFDropdown extends StatefulWidget {
  List<WFDropdownItem> list = [];
  String? selectedId;
  List<String>? selectedIds;
  String title = "";
  String labelText = "";
  String hintText = "";
  bool enabled = true;
  InputBorder border = const OutlineInputBorder();
  bool searchable = true;
  String prefixSeparator = _has;
  String suffixSeparator = _comma;
  Color selectedBackgroundColor = Colors.black12;
  String searchBoxHintText = _searchHere;
  IconData prefixSearchBoxIcon = _icSearch;
  String negativeButtonText = _cancel;
  String positiveButtonText = _ok;
  Color negativeButtonTextColor = Colors.red;
  Color positiveButtonTextColor = Colors.black;
  Function(WFDropdownItem selectedItem)? onSingleItemListener;
  Function(List<WFDropdownItem> selectedItemList)? onMultipleItemListener;
  bool _isMultiple = false;

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
        this.searchable = true,
        this.selectedBackgroundColor = Colors.black12,
        this.searchBoxHintText = _searchHere,
        this.prefixSearchBoxIcon = _icSearch,
        this.negativeButtonText = _cancel,
        this.negativeButtonTextColor = Colors.red})
      : super(key: key) {
    _isMultiple = false;
    selectedId = selectedId ?? "";
    selectedIds = selectedIds ?? [];
  }

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
        this.searchable = true,
        this.prefixSeparator = _has,
        this.suffixSeparator = _comma,
        this.selectedBackgroundColor = Colors.black12,
        this.searchBoxHintText = _searchHere,
        this.prefixSearchBoxIcon = _icSearch,
        this.negativeButtonText = _cancel,
        this.positiveButtonText = _ok,
        this.negativeButtonTextColor = Colors.red,
        this.positiveButtonTextColor = Colors.black})
      : super(key: key) {
    _isMultiple = true;
    selectedIds = selectedIds ?? [];
  }

  @override
  State<WFDropdown> createState() => _WFDropdownState();
}

class _WFDropdownState extends State<WFDropdown> {
  final TextEditingController _conSelectedValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialSetup();
  }

  _initialSetup() {
    String selectedValue = _getSelectedValue(list: widget.list);
    _conSelectedValue.text = selectedValue;
  }

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
        openDropdown(
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

  openDropdown(
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
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: widget.searchable,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: widget.searchBoxHintText,
                                prefixIcon: Icon(widget.prefixSearchBoxIcon)),
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
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        key: const PageStorageKey<String>('list'),
                        shrinkWrap: true,
                        itemCount: _fList.length,
                        itemBuilder: (context, index) {
                          return _dropdownItemView(
                              context, isMultiple, _fList[index], setState);
                        },
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

  _dropdownItemView(BuildContext context, bool isMultiple, WFDropdownItem obj,
      StateSetter setState) {
    return InkWell(
        onTap: () {
          if (isMultiple) {
            setState(() {
              obj.selected = !obj.selected;
            });
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
          margin: const EdgeInsets.only(top: 10, bottom: 10),
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
