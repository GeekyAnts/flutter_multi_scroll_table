import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

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
