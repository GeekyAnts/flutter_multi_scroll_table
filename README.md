<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# A multi-direction widget for showing the list in Flutter.

A Flutter package used to show list scrollable in both vertical and horizontal direction.

## Features

- **Sort by Column:** You can now sort the columns of the table by clicking on the header. This feature allows you to organize your data in ascending or descending order.

- **More Options for EachCell:** EachCell widget now supports additional customization options, including background color and other styling properties. This enables more flexible and visually appealing table designs.

- **Adjustable Columns:** The columns of the table are now dynamically adjustable. You can resize the width of each column by dragging, providing a more tailored view of your data.

- **Rotation Feature:** The table now supports viewing in both portrait and landscape modes. The layout adjusts automatically to fit the orientation, ensuring an optimal viewing experience on all devices.


https://github.com/user-attachments/assets/d6580a5f-1b32-49a8-92cd-d252d5a53cab


## Installation

First, add `flutter_multi_scroll_table` as a
[dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Usage

```dart
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

```

Easy to use , just call the widget name

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
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 900,
        height: 500,
        tableBorder: Border(),
        fixedColumnHeader: [
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
        ],
        fixedColumnChildren: [
          _numbers.map((number) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: number.toString(),
                  width: 80,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            );
          }).toList(),
          _randomAlphabets.map((number) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: number.toString(),
                  width: 90,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            );
          }).toList(),
        ],
        scrollableColumnChildren: [
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.names[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          List.generate(
            20,
            (index) => Column(
              children: [
                EachCell(
                  text: CommonUtils.cities[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.fruits[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.carBrands[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.countries[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.countryCodes[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.countryCodes[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.countryCodes[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.countryCodes[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.countryCodes[index],
                  width: 100,
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
        scrollableColumnHeader: [
          EachCell(
            text: "Members",
            width: 100,
            textStyle: headerTextStyle,
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
            textStyle: headerTextStyle,
            width: 100,
            isHeader: true,
          ),
          EachCell(
            text: "Random 1",
            textStyle: headerTextStyle,
            width: 100,
            isHeader: true,
          ),
          EachCell(
            text: "Random 2",
            textStyle: headerTextStyle,
            width: 100,
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
        ],
      ),
    );
  }
}

```

## Parameters

| Parameters                 | Description                                                                                                                    |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `totalWidth`               | **Required**. The total width of the table.                                                                                    |
| `fixedColumnHeader`        | **Required**. The header widgets for the fixed columns which are scrollable only in vertical direction.                        |
| `height`                   | Optional. The total height of the list view. Default is 500.                                                                   |
| `scrollableColumnHeader`   | **Required**. The header widgets for the scrollable columns which are scrollable in both vertical and horizontal directions.   |
| `scrollableColumnChildren` | **Required**. The children widgets for the scrollable columns which are scrollable in both vertical and horizontal directions. |
| `fixedColumnChildren`      | **Required**. The children widgets for the fixed columns which are scrollable only in vertical direction.                      |
| `isAscending`              | Optional. Whether the sorting is in ascending order. Default is true.                                                          |
| `tableBorder`              | Optional. The border for the table.                                                                                            |
| `draggableIcon`            | Optional. The icon displayed for dragging the column width.                                                                    |

## Additional information

This package is in a very early stages of development and quite experimental.

<!-- TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more. -->
