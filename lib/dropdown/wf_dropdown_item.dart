class WFDropdownItem {
  String id;
  String value;
  bool selected = false;
  dynamic data;

  WFDropdownItem(
      {this.id = "", this.value = "", this.data});

  static List<WFDropdownItem> cloneList(List<WFDropdownItem> list) {
    List<WFDropdownItem> cloneList = [];
    for (WFDropdownItem obj in list) {
      cloneList.add(obj);
    }
    return cloneList;
  }
}
