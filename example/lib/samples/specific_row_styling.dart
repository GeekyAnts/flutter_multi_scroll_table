import 'package:example/screens/widgets/appbar.dart';
import 'package:example/utils/strings.dart';
import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

class SpecificRowStylingTableExample extends StatefulWidget {
  const SpecificRowStylingTableExample({super.key});

  @override
  State<SpecificRowStylingTableExample> createState() =>
      _SpecificRowStylingTableExampleState();
}

class _SpecificRowStylingTableExampleState
    extends State<SpecificRowStylingTableExample> {
  // Define your headerTextStyle
  final TextStyle? headerTextStyle = const TextStyle(
    fontWeight: FontWeight.w900,
  );
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
        title: AppStrings.specificRowStylingTableTitle,
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

              // To highlight a specific element at a particular row and column,
              // for example, changing the background color and text style of
              // the element at row 0 and column 1:
              if (rowIndex == 0) {
                rowChildren[1] = rowChildren[1].copyWith(
                  dataBackgroundColor: Colors.red,
                  dataTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                );
              }
            },
            dataList: CommonUtils.footballTableData,
            fixedCount: 0,
          ),
        ],
      ),
    );
  }
}
