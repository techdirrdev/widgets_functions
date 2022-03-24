import 'package:widgets_functions/utils.dart';

// dropdown item model class
class WFDropdownItem {
  String id;
  String value;
  bool selected = false;
  dynamic data;

  // constructor for dropdown item class
  WFDropdownItem({this.id = "", this.value = "", this.data});

  @override
  String toString() {
    return value;
  }

  // generate clone list of dropdown item
  static List<WFDropdownItem> cloneList(List<WFDropdownItem> list) {
    List<WFDropdownItem> cloneList = [];
    for (WFDropdownItem obj in list) {
      cloneList.add(obj);
    }
    return cloneList;
  }

  static WFDropdownItem? selectedItemById(
      List<WFDropdownItem> list, String id) {
    WFDropdownItem? selectedItem;
    for (WFDropdownItem obj in list) {
      if (Utils.equals(id, obj.id)) {
        selectedItem = obj;
        break;
      }
    }
    if (selectedItem == null && list.isNotEmpty) {
      selectedItem = list[0];
    }
    return selectedItem;
  }

  static WFDropdownItem? selectedItemByValue(
      List<WFDropdownItem> list, String value) {
    WFDropdownItem? selectedItem;
    for (WFDropdownItem obj in list) {
      if (Utils.equals(value, obj.value)) {
        selectedItem = obj;
        break;
      }
    }
    if (selectedItem == null && list.isNotEmpty) {
      selectedItem = list[0];
    }
    return selectedItem;
  }
}
