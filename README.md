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
  final TextStyle? headerTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  final TextStyle? dataTextStyle = const TextStyle(
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    // // Column Headers list
    final headers = [
      const EachCell(
        text: "Sr. No",
        width: 60,
      ),
      const EachCell(
        text: "Random",
        width: 90,
        isExpandable: true,
      ),
      const EachCell(
        text: "Members",
        width: 100,
        isExpandable: true,
      ),
      const EachCell(
        text: "Cities",
        width: 100,
      ),
      const EachCell(
        text: "Fruits",
        width: 100,
      ),
      const EachCell(
        text: "Cars",
        width: 100,
      ),
      const EachCell(
        text: "Countries",
        width: 100,
        isExpandable: true,
      ),
      const EachCell(
        text: "Codes",
        width: 100,
      ),
      const EachCell(
        text: "Random 1",
        width: 100,
      ),
      const EachCell(
        text: "Random 2",
        width: 100,
      ),
      const EachCell(
        text: "Random 3",
        width: 100,
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 900,
        height: 480,
        headers: headers,
        headerTextStyle: headerTextStyle,
        dataList: CommonUtils.dataList,
        // jsonDataList: CommonUtils.jsonDataList,
        fixedCount: 2,
        onGenerateRowConfiguration: (rowIndex, rowChildren) {
          if (rowIndex == 3) {
            for (int i = 0; i < rowChildren.length; i++) {
              rowChildren[i] = (rowChildren[i]).copyWith(
                  dataBackgroundColor: Colors.blue,
                  dataTextStyle: const TextStyle(
                    color: Colors.white,
                  ));
            }
          }
        },
      ),
    );
  }
}


```

## Parameters

| Parameters                   | Description                                                                                                                                |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `headers`                    | A list of `EachCell` widgets representing the headers for all columns, both fixed and scrollable.                                          |
| `dataList`                   | A list of lists representing row-wise data. ( **Note**: headers must be provided for dataList )                                            |
| `jsonDataList`               | A list of maps representing row-wise data. Any missing data will automatically be replaced with "--"                                       |
| `fixedCount`                 | **Required**. The number of columns that are fixed (not scrollable horizontally).                                                          |
| `totalWidth`                 | **Required**. The total width of the table.                                                                                                |
| `height`                     | The total height of the table. Default is 500.                                                                                             |
| `headerTextStyle`            | The text style applied to the header cells.                                                                                                |
| `dataTextStyle`              | The text style applied to the data cells.                                                                                                  |
| `isAscending`                | Whether the sorting is in ascending order. Default is true.                                                                                |
| `tableBorder`                | The border for the table, provided as a `BoxBorder`.                                                                                       |
| `tableDividerThickness`      | Specifies the thickness of the dividers between the rows of the table. Default is 1.0.                                                     |
| `tableDividerColor`          | Specifies the color of the dividers between the rows of the table. Default is Colors.black                                                 |
| `draggableIcon`              | The icon displayed for dragging to adjust the column width.                                                                                |
| `onGenerateRowConfiguration` | A callback function that takes the row index and a list of `EachCell` for that row. Used to customize row-specific properties dynamically. |

## EachCell Parameters

| Parameters              | Description                                                                                                                                                                         |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `text`                  | **Required**. The text content of the cell.                                                                                                                                         |
| `isHeader`              | Optional. Whether the cell is a header cell. Default is `false`.                                                                                                                    |
| `isLeftAlign`           | Optional. Whether the text should be left-aligned. Default is `false`.                                                                                                              |
| `width`                 | Optional. The width of the cell.                                                                                                                                                    |
| `height`                | Optional. The height of the cell. Default height is 40.                                                                                                                             |
| `headerTextStyle`       | Optional. The text style applied to the header cell content.                                                                                                                        |
| `dataTextStyle`         | Optional. The text style applied to the data cell content.                                                                                                                          |
| `headerBackgroundColor` | Optional. The background color of the header cell.                                                                                                                                  |
| `dataBackgroundColor`   | Optional. The background color of the data cell.                                                                                                                                    |
| `padding`               | Optional. The padding inside the cell.                                                                                                                                              |
| `margin`                | Optional. The margin outside the cell.                                                                                                                                              |
| `border`                | Optional. The border of the cell.                                                                                                                                                   |
| `borderRadius`          | Optional. The border radius of the cell.                                                                                                                                            |
| `isExpandable`          | Optional. Whether the cell is expandable. Default is `false`.                                                                                                                       |
| `priority`              | Optional. The priority of the cell, determining its order among other cells. A lower value indicates higher priority. If not provided, the cell will not be prioritized explicitly. |

## Additional information

This package is in a very early stages of development and quite experimental.
