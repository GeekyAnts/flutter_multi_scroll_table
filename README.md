# A multi-direction widget for showing the list in Flutter.

A Flutter package used to show list scrollable in both vertical and horizontal direction.

## Features

- **Sort by Column:** You can now sort the columns of the table by clicking on the header. This feature allows you to organize your data in ascending or descending order.

- **More Options for EachCell:** EachCell widget now supports additional customization options, including background color and other styling properties. This enables more flexible and visually appealing table designs.

- **Adjustable Columns:** The columns of the table are now dynamically adjustable. You can resize the width of each column by dragging, providing a more tailored view of your data.

- **Rotation Feature:** The table now supports viewing in both portrait and landscape modes. The layout adjusts automatically to fit the orientation, ensuring an optimal viewing experience on all devices.

https://github.com/user-attachments/assets/2ab33486-2b41-45f0-bcd3-52dcbc13dbfb

https://github.com/user-attachments/assets/d6580a5f-1b32-49a8-92cd-d252d5a53cab

## Installation

First, add `flutter_multi_scroll_table` as a
[dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Usage

```dart
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

```

```dart

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final List<int> _numbers = List.generate(20, (index) => index + 1)..shuffle();

  final List<String> _randomAlphabets =
      List.generate(20, (_) => CommonUtils.generateRandomAlphabet());

  final TextStyle? headerTextStyle =
      const TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    // Column Headers list
    final headers = [
      EachCell(
        text: "Sr. No",
        width: 60,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random",
        width: 90,
        textStyle: headerTextStyle,
        isHeader: true,
        isExpandable: true,
      ),
      EachCell(
        text: "Members",
        width: 100,
        textStyle: headerTextStyle,
        isExpandable: true,
        isHeader: true,
      ),
      EachCell(
        text: "Cities",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Fruits",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Cars",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Countries",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
        isExpandable: true,
      ),
      EachCell(
        text: "Codes",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random 1",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random 2",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random 3",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random 4",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
    ];

    // Column Children list

    final columnChildren = [
      _numbers.map((number) {
        return EachCell(
          text: number.toString(),
          width: 80,
          height: 45,
        );
      }).toList(),
      _randomAlphabets.map((number) {
        return EachCell(
          text: number.toString(),
          width: 90,
          height: 45,
        );
      }).toList(),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.names[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.cities[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.fruits[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.carBrands[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countries[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 900,
        height: 480,
        headers: headers,
        columnChildren: columnChildren,
        fixedCount: 3,
      ),
    );
  }
}


```

## Parameters

| Parameters       | Description                                                                       |
| ---------------- | --------------------------------------------------------------------------------- |
| `headers`        | **Required**. The header widgets for all columns, both fixed and scrollable.      |
| `columnChildren` | **Required**. The children widgets for all columns, both fixed and scrollable.    |
| `fixedCount`     | **Required**. The number of columns that are fixed (not scrollable horizontally). |
| `totalWidth`     | **Required**. The total width of the table.                                       |
| `height`         | Optional. The total height of the table. Default is 500.                          |
| `isAscending`    | Optional. Whether the sorting is in ascending order. Default is true.             |
| `tableBorder`    | Optional. The border for the table.                                               |
| `draggableIcon`  | Optional. The icon displayed for dragging the column width.                       |
|                  |

## Additional information

This package is in a very early stages of development and quite experimental.
