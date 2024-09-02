# A multi-direction widget for showing the list in Flutter.

A Flutter package used to show list scrollable in both vertical and horizontal direction.

## Features

- **Sort by Column:** You can now sort the columns of the table by clicking on the header. This feature allows you to organize your data in ascending or descending order.

- **More Options for EachCell:** EachCell widget now supports additional customization options, including background color and other styling properties. This enables more flexible and visually appealing table designs.

- **Adjustable Columns:** The columns of the table are now dynamically adjustable. You can resize the width of each column by dragging, providing a more tailored view of your data.

- **Rotation Feature:** The table now supports viewing in both portrait and landscape modes. The layout adjusts automatically to fit the orientation, ensuring an optimal viewing experience on all devices.

https://github.com/user-attachments/assets/0559232c-397c-452c-a623-0f0fb447d546

## Installation

Add the package to your dependencies:

```yaml
dependencies:

flutter_multi_scroll_table: ^0.0.1
```

## Usage

The following example demonstrates how to use the FlutterMultiScrollTable widget by passing a `dataList` and corresponding `headers`

In this example, a list of headers is defined, specifying column names such as "Sr. No", "Members", "Cities", and more. The dataList contains the actual data for each row in the table, where each inner list represents a row with values corresponding to the headers. The table is customizable with properties like `headerTextStyle` and `dataTextStyle`, allowing you to style the table to your needs.

Additionally, specific rows can be customized using the `onGenerateRowConfiguration` callback. The `fixedCount` parameter ensures that the first two columns remain fixed during horizontal scrolling.

```dart
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

```

```dart
static final List<List<dynamic>> dataList = [
  [1, 'John Doe', 'New York', 'Apple', 'Tesla', 'USA', '+1', 'X', 'Y', 'Z', 'W'],
  [2, 'Jane Smith', 'London', 'Banana', 'BMW', 'UK', '+44', 'M', 'N', 'O', 'P'],
  [3, 'Alice Johnson', 'Sydney', 'Orange', 'Mercedes', 'Australia', '+61', 'A1', 'B1', 'C1', 'D1'],
  [4, 'Michael Brown', 'Paris', 'Grapes', 'Audi', 'France', '+33', 'E', 'F', 'G', 'H'],
  [5, 'Emily Davis', 'Berlin', 'Strawberry', 'Porsche', 'Germany', '+49', 'I', 'J', 'K', 'L'],
  [6, 'Chris Wilson', 'Rome', 'Peach', 'Ferrari', 'Italy', '+39', 'M', 'N', 'O', 'P'],
  [7, 'Jessica Lee', 'Madrid', 'Blueberry', 'Seat', 'Spain', '+34', 'Q', 'R', 'S', 'T'],
  [8, 'David Martinez', 'Amsterdam', 'Pineapple', 'Volvo', 'Netherlands', '+31', 'U', 'V', 'W', 'X'],
  [9, 'Sophia Clark', 'Vienna', 'Cherry', 'Skoda', 'Austria', '+43', 'Y', 'Z', 'A2', 'B2'],
  [10, 'Daniel Lewis', 'Zurich', 'Mango', 'BMW', 'Switzerland', '+41', 'C2', 'D2', 'E2', 'F2'],
  [11, 'Olivia Walker', 'Brussels', 'Melon', 'Audi', 'Belgium', '+32', 'G2', 'H2', 'I2', 'J2'],
  [12, 'James Allen', 'Prague', 'Kiwi', 'Tesla', 'Czech Republic', '+420', 'K2', 'L2', 'M2', 'N2'],
];


```

```dart

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  // Define your headerTextStyle
  final TextStyle? headerTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );
  // Define your dataTextStyle
  final TextStyle? dataTextStyle = const TextStyle(
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    // Column Headers list
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

In the second example, the FlutterMultiScrollTable is used with a `jsonDataList`, where the headers are automatically generated based on the keys of the JSON data. However, you still have the flexibility to pass headers explicitly if needed. The headers will map directly to the JSON keys, making it easy to create dynamic tables from JSON data.

```dart


 static final List<Map<String, dynamic>> jsonDataList = [
  {"Sr. No": 1, "Random": "A", "Members": "John Doe", "Cities": "New York", "Fruits": "Apple", "Cars": "Tesla", "Countries": "USA", "Codes": "+1", "Random 1": "X", "Random 2": "Y", "Random 3": "Z", "Random 4": "W"},
  {"Sr. No": 2, "Random": "B", "Members": "Jane Smith", "Cities": "London", "Fruits": "Banana", "Cars": "BMW", "Countries": "UK", "Codes": "+44", "Random 1": "M", "Random 2": "N", "Random 3": "O", "Random 4": "P"},
  {"Sr. No": 3, "Random": "C", "Members": "Alice Johnson", "Cities": "Sydney", "Fruits": "Orange", "Cars": "Mercedes", "Countries": "Australia", "Codes": "+61", "Random 1": "A1", "Random 2": "B1", "Random 3": "C1", "Random 4": "D1"},
  {"Sr. No": 4, "Random": "D", "Members": "Michael Brown", "Cities": "Paris", "Fruits": "Grapes", "Cars": "Audi", "Countries": "France", "Codes": "+33", "Random 1": "E", "Random 2": "F", "Random 3": "G", "Random 4": "H"},
  {"Sr. No": 5, "Random": "E", "Members": "Emily Davis", "Cities": "Berlin", "Fruits": "Strawberry", "Cars": "Porsche", "Countries": "Germany", "Codes": "+49", "Random 1": "I", "Random 2": "J", "Random 3": "K", "Random 4": "L"},
  {"Sr. No": 6, "Random": "F", "Members": "Chris Wilson", "Cities": "Rome", "Fruits": "Peach", "Cars": "Ferrari", "Countries": "Italy", "Codes": "+39", "Random 1": "M", "Random 2": "N", "Random 3": "O", "Random 4": "P"},
  {"Sr. No": 7, "Random": "G", "Members": "Jessica Lee", "Cities": "Madrid", "Fruits": "Blueberry", "Cars": "Seat", "Countries": "Spain", "Codes": "+34", "Random 1": "Q", "Random 2": "R", "Random 3": "S", "Random 4": "T"},
  {"Sr. No": 8, "Random": "H", "Members": "David Martinez", "Cities": "Amsterdam", "Fruits": "Pineapple", "Cars": "Volvo", "Countries": "Netherlands", "Codes": "+31", "Random 1": "U", "Random 2": "V", "Random 3": "W", "Random 4": "X"},
  {"Sr. No": 9, "Random": "I", "Members": "Sophia Clark", "Cities": "Vienna", "Fruits": "Cherry", "Cars": "Skoda", "Countries": "Austria", "Codes": "+43", "Random 1": "Y", "Random 2": "Z", "Random 3": "A2", "Random 4": "B2"},
  {"Sr. No": 10, "Random": "J", "Members": "Daniel Lewis", "Cities": "Zurich", "Fruits": "Mango", "Cars": "BMW", "Countries": "Switzerland", "Codes": "+41", "Random 1": "C2", "Random 2": "D2", "Random 3": "E2", "Random 4": "F2"},
  {"Sr. No": 11, "Random": "K", "Members": "Olivia Walker", "Cities": "Brussels", "Fruits": "Melon", "Cars": "Audi", "Countries": "Belgium", "Codes": "+32", "Random 1": "G2", "Random 2": "H2", "Random 3": "I2", "Random 4": "J2"},
  {"Sr. No": 12, "Random": "L", "Members": "James Allen", "Cities": "Prague", "Fruits": "Kiwi", "Cars": "Tesla", "Countries": "Czech Republic", "Codes": "+420", "Random 1": "K2", "Random 2": "L2", "Random 3": "M2", "Random 4": "N2"},
];


```

```dart


class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  // Define your headerTextStyle
  final TextStyle? headerTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );
  // Define your dataTextStyle
  final TextStyle? dataTextStyle = const TextStyle(
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 900,
        height: 480,
        headerTextStyle: headerTextStyle,
        dataTextStyle: dataTextStyle,
        jsonDataList: CommonUtils.jsonDataList,
        fixedCount: 2,
      ),
    );
  }
}


```

##### Fixed Column Table Example ([Source Code](/example/lib/samples/fixed_column_table.dart))

https://github.com/user-attachments/assets/1722ad98-21f0-4b34-8c2f-7c70438b7f3f

##### Scrollable Column Table Example ([Source Code](/example/lib/samples/scrollable_table.dart))

https://github.com/user-attachments/assets/c0c8e69a-f25d-4361-a406-be14bb39c5f6

##### Styled Table Example ([Source Code](/example/lib/samples/styled_scrollable_table.dart))

https://github.com/user-attachments/assets/e7448149-1db2-4d57-b0f6-3cebdb82d927

##### JSON Data Table Example ([Source Code](/example/lib/samples/json_data_table.dart))

https://github.com/user-attachments/assets/6367514b-1432-4a4f-93a4-b491648529a4

##### Specific Row Style Table Example ([Source Code](/example/lib/samples/specific_row_styling.dart))

https://github.com/user-attachments/assets/df3dae3c-d3e8-4e2d-9683-1daf84987790

##### Expandable Column Table Example ([Source Code](/example/lib/samples/expandable_column_table.dart))

https://github.com/user-attachments/assets/81207fd9-bb6d-4be1-a8ea-fbf4613f237f

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
| `headerBackgroundColor`      | The background color to be applied to all header cells.                                                                                    |
| `dataBackgroundColor`        | The background color to be applied to all data cells.                                                                                      |
| `isAscending`                | Whether the sorting is in ascending order. Default is true.                                                                                |
| `tableBorder`                | The border for the table, provided as a `BoxBorder`.                                                                                       |
| `tableDividerThickness`      | Specifies the thickness of the dividers between the rows of the table. Default is 1.0.                                                     |
| `tableDividerColor`          | Specifies the color of the dividers between the rows of the table. Default is Colors.black                                                 |
| `dataPlaceholder`            | A placeholder string that will be used to replace any missing or null data in the table.                                                   |
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
