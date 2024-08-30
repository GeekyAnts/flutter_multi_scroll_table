import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

import '../screens/widgets/appbar.dart';
import '../utils/strings.dart';

class FixedColumnTableExample extends StatefulWidget {
  const FixedColumnTableExample({super.key});

  @override
  State<FixedColumnTableExample> createState() =>
      _FixedColumnTableExampleState();
}

class _FixedColumnTableExampleState extends State<FixedColumnTableExample> {
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
      EachCell(
        text: "Team ID",
        width: 80,
        headerBackgroundColor: Colors.blue.shade800,
        headerTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        dataBackgroundColor: Colors.blue,
        dataTextStyle: const TextStyle(color: Colors.white),
      ),
      EachCell(
        text: "Team Name",
        width: 150,
        headerBackgroundColor: Colors.blue.shade800,
        headerTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        dataBackgroundColor: Colors.blue,
        dataTextStyle: const TextStyle(color: Colors.white),
      ),
      const EachCell(
        text: "Home Stadium",
        width: 120,
      ),
      const EachCell(
        text: "Country",
        width: 100,
      ),
      const EachCell(
        text: "Founded Year",
        width: 100,
      ),
      const EachCell(
        text: "Manager",
        width: 150,
      ),
    ];

    return Scaffold(
      appBar: const TableAppBar(
        title: AppStrings.fixedColumnTableTitle,
      ),
      backgroundColor: Colors.white,
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
            fixedCount: 2,
          ),
        ],
      ),
    );
  }
}
