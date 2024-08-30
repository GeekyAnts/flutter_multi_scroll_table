import 'package:example/screens/widgets/appbar.dart';
import 'package:example/utils/strings.dart';
import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

class ExpandableColumnTableExample extends StatefulWidget {
  const ExpandableColumnTableExample({super.key});

  @override
  State<ExpandableColumnTableExample> createState() =>
      _ExpandableColumnTableExampleState();
}

class _ExpandableColumnTableExampleState
    extends State<ExpandableColumnTableExample> {
  // Define your headerTextStyle
  final TextStyle? headerTextStyle =
      const TextStyle(fontWeight: FontWeight.w900);
  // Define your dataTextStyle
  final TextStyle? dataTextStyle = const TextStyle(
    fontWeight: FontWeight.w100,
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
      EachCell(
        text: "Home Stadium",
        width: 150,
        isExpandable: true,
        headerBackgroundColor: Colors.blueAccent,
        headerTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        dataBackgroundColor: Colors.blue.withOpacity(0.1),
        dataTextStyle: TextStyle(
          color: Colors.blue.shade900,
        ),
      ),
      const EachCell(
        text: "Country",
        width: 100,
      ),
      const EachCell(
        text: "Year",
        width: 120,
      ),
      const EachCell(
        text: "Captain",
        width: 150,
      ),
    ];

    return Scaffold(
      appBar: const TableAppBar(
        title: AppStrings.expandableColumnTableTitle,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          FlutterMultiScrollTable(
            totalWidth: 700,
            height: 450,
            headers: headers,
            headerTextStyle: headerTextStyle,
            dataList: CommonUtils.cricketTeamData,
            fixedCount: 1,
            draggableIcon: const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
