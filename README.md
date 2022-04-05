# widgets_functions

Custom Widgets and Functions, Widgets and Function easy to access, reuse and no longer code.

## Using

For help getting started with Flutter, view our
[online documentation](https://pub.dev/documentation/widgets_functions/latest), which offers tutorials,
samples, guidance on mobile and web development, and a full API reference.

## Installation

First, add `widgets_functions` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

In your flutter project add the dependency:

```yml
dependencies:
  ...
  widgets_functions:
```

For help getting started with Flutter, view the online
[documentation](https://flutter.io/).

## Example

Please follow this [example](https://github.com/techdirr/widgets_functions/tree/master/example) here.


### Text Field

```dart
WFTextField(labelText: "Value", hintText: "Value")
```


### Dropdown - Single Selection and Multi Selection

1. Declare variables
```dart
List<WFDropdownItem> _itemList = [];
String _singleSelectedId = ""; //for single selection dropdown
final List<String> _mutiSelectedIds = []; //for multi selection dropdown
```

2. Generate your item list
```dart
_generateItems() {
  List<WFDropdownItem> list = [];
  for (int i = 1; i <= 20; i++) {
    list.add(WFDropdownItem(
        id: "$i",
        value: "Item $i",
        data: User(userId: "$i", userName: "User $i") /* User class is another data class (use any datatype in data field )*/
    ));
  }
  setState(() {
    _itemList = list;
  });
}
```

3. put WFDropdown in your build function

Single Selection Dropdown
```dart
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
    User user = selectedItem.data as User;
    log("Item Id: $itemId -- Item Name: $itemName ## Other Details ## User Id: ${user.userId} -- User Name: ${user.userName}");
})
```

Multi Selection Dropdown
```dart
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
      User user = selectedItem.data as User;
      log("Item Id: $itemId -- Item Name: $itemName ## Other Details ## User Id: ${user.userId} -- User Name: ${user.userName}");
    }
})
```


### Date Picker and Time Picker

1. Declare variables
```dart
String _selectedDate = DateTimes.getCurrentDateTime();
String _selectedTime = DateTimes.getCurrentTime();
final TextEditingController _conDate = TextEditingController();
final TextEditingController _conTime = TextEditingController();
```

2. put DateTimes.datePicker or DateTimes.timePicker in your build function

Date Picker
```dart
WFTextField(
  controller: _conDate
    ..text = DateTimes.reverseDate(date: _selectedDate),
  labelText: "Date",
  hintText: "Select Date",
  readOnly: true,
  onTap: () {
    DateTimes.datePicker(
        context: context,
        date: _selectedDate,
        dateTime: (date) {
          log(date);
          setState(() {
            _selectedDate = date;
          });
        });
  },
)
```

Time Picker
```dart
WFTextField(
  controller: _conTime
    ..text = DateTimes.periodTime(time: _selectedTime),
  labelText: "Time",
  hintText: "Select Time",
  readOnly: true,
  onTap: () {
    DateTimes.timePicker(
        context: context,
        time: _selectedTime,
        dateTime: (time) {
          log(time);
          setState(() {
            _selectedTime = time;
          });
        });
  },
)
```

