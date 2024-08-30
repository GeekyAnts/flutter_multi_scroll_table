import 'package:example/screens/widgets/appbar.dart';
import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

import '../utils/strings.dart';

class ScrollableTableExample extends StatefulWidget {
  const ScrollableTableExample({super.key});

  @override
  State<ScrollableTableExample> createState() => _ScrollableTableExampleState();
}

class _ScrollableTableExampleState extends State<ScrollableTableExample> {
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
        text: "Team ID",
        width: 80,
      ),
      const EachCell(
        text: "Team Name",
        width: 150,
      ),
      const EachCell(
        text: "Home Stadium",
        width: 150,
      ),
      const EachCell(
        text: "Country",
        width: 100,
      ),
      const EachCell(
        text: "Founded Year",
        width: 120,
      ),
      const EachCell(
        text: "Manager",
        width: 150,
      ),
    ];
    return Scaffold(
      appBar: const TableAppBar(
        title: AppStrings.scrollableTableTitle,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          FlutterMultiScrollTable(
            totalWidth: 600,
            height: 450,
            headers: headers,
            headerTextStyle: headerTextStyle,
            dataList: CommonUtils.footballTableData,
            fixedCount: 0,
          ),
        ],
      ),
    );
  }
}
