import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final TextStyle? headerTextStyle =
      const TextStyle(fontWeight: FontWeight.bold);

  final TextStyle? dataTextStyle = const TextStyle(
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    // // Column Headers list
    final headers = [
      EachCell(
        text: "Sr. No",
        width: 60,
        headerTextStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random",
        width: 90,
        headerTextStyle: headerTextStyle,
        isHeader: true,
        isExpandable: true,
      ),
      EachCell(
        text: "Members",
        width: 100,
        headerTextStyle: headerTextStyle,
        isExpandable: true,
        isHeader: true,
      ),
      EachCell(
        text: "Cities",
        width: 100,
        headerTextStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Fruits",
        width: 100,
        headerTextStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Cars",
        width: 100,
        headerTextStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Countries",
        width: 100,
        headerTextStyle: headerTextStyle,
        isHeader: true,
        isExpandable: true,
      ),
      EachCell(
        text: "Codes",
        width: 100,
        headerTextStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random 1",
        width: 100,
        headerTextStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random 2",
        width: 100,
        headerTextStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random 3",
        width: 100,
        headerTextStyle: headerTextStyle,
        isHeader: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 900,
        height: 480,
        headers: headers,
        //dataList: CommonUtils.dataList,
        jsonDataList: CommonUtils.jsonDataList,
        fixedCount: 2,
        onGenerateRowConfiguration: (rowIndex, rowChildren) {
          if (rowIndex == 3 || rowIndex == 5) {
            for (int i = 0; i < rowChildren.length; i++) {
              rowChildren[i] = (rowChildren[i]).copyWith(
                  dataBackgroundColor: Colors.red,
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
