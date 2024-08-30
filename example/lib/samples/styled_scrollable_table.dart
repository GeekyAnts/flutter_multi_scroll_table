import 'package:example/screens/widgets/appbar.dart';
import 'package:example/utils/strings.dart';
import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

class StyledScrollableTableExample extends StatefulWidget {
  const StyledScrollableTableExample({super.key});

  @override
  State<StyledScrollableTableExample> createState() =>
      _StyledScrollableTableExampleState();
}

class _StyledScrollableTableExampleState
    extends State<StyledScrollableTableExample> {
  // Define your headerTextStyle
  final TextStyle? headerTextStyle =
      const TextStyle(fontWeight: FontWeight.w900, color: Colors.white);
  // Define your dataTextStyle
  final TextStyle? dataTextStyle =
      TextStyle(fontWeight: FontWeight.w400, color: Colors.purple.shade900);

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
        title: AppStrings.styledTableTitle,
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
            headerBackgroundColor: Colors.deepPurpleAccent,
            dataTextStyle: dataTextStyle,
            dataBackgroundColor: Colors.deepPurpleAccent.withOpacity(0.05),
            tableDividerColor: Colors.deepPurpleAccent,
            tableBorder: Border.all(color: Colors.deepPurpleAccent),
            dataList: CommonUtils.footballTableData,
            fixedCount: 0,
          ),
        ],
      ),
    );
  }
}
