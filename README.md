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

## Installation

First, add `flutter_multi_scroll_table` as a
[dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

<!-- ## Features

TODO: List what your package can do. Maybe include images, gifs, or videos. -->

## Usage

Easy to use , just call the widget name

```dart
class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 700,
        height: 500,
        scrollableColumnChildren: List.generate(
          20,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  EachCell(
                    text: Utils.names[index],
                    width: 120,
                    // height: 60,
                  ),
                  const EachCell(
                    text: "B",
                    width: 50,
                  ),
                  const EachCell(
                    text: "C",
                    width: 50,
                  ),
                  const EachCell(
                    text: "D",
                    width: 50,
                  ),
                  const EachCell(
                    text: "E",
                    width: 50,
                  ),
                  const EachCell(
                    text: "F",
                    width: 50,
                  ),
                  const EachCell(
                    text: "G",
                    width: 50,
                  ),
                  const EachCell(
                    text: "H",
                    width: 50,
                  )
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2),
                width: 600 - 60,
                child: const Divider(
                  height: 1,
                ),
              ),
            ],
          ),
        ),
        fixedColumnChildren: [
          Utils.srNumbers.map((number) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: number.toString(),
                  width: 80,
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            );
          }).toList(),
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EachCell(
                  text: "Y",
                  width: 80,
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Divider(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Utils.numbers.map((number) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: number.toString(),
                  width: 80,
                ),
                const SizedBox(height: 5),
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
        fixedColumnTitles: const ["S.no", 'A', 'B'],
        columns: const [
          EachCell(
            text: "Members",
            width: 120,
            isHeader: true,
          ),
          EachCell(
            text: "A",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "B",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "C",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "D",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "E",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "F",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "G",
            width: 50,
            isHeader: true,
          ),
        ],
        fixedColumnWidths: const [40, 40, 40],
      ),
    );
  }
}
```

## Parameters

| Parameters               | Description                                                                                                                     |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| totalWidth               | Required parameter for giving the width to the list view.                                                                       |
| fixedColumnWidths        | Required parameter for the fixed columns which are scrollable only in vertical direction.                                       |
| height                   | Optional parameter that denotes the total height of the list view.                                                              |
| fixedColumnNames         | Optional parameter that denotes the fixed columns name.                                                                         |
| scrollableColumnChildren | Required parameter used to show list items which is scrollable in both vertical and horizontal direction.                       |
| fixedColumnChildren      | Required parameter used to show list items which is scrollable only in vertical direction.                                      |
| columns                  | Required parameter used to give the column names for list items which is scrollable in both vertical and horizontal directions. |

## Additional information

This package is in a very early stages of development and quite experimental.

<!-- TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more. -->
