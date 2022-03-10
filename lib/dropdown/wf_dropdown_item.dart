// dropdown item model class
class WFDropdownItem {
  String id;
  String value;
  bool selected = false;
  dynamic data;

  // constructor for dropdown item class
  WFDropdownItem({this.id = "", this.value = "", this.data});

  // generate clone list of dropdown item
  static List<WFDropdownItem> cloneList(List<WFDropdownItem> list) {
    List<WFDropdownItem> cloneList = [];
    for (WFDropdownItem obj in list) {
      cloneList.add(obj);
    }
    return cloneList;
  }
}
