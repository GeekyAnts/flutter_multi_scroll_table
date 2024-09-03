import 'package:example/screens/widgets/appbar.dart';
import 'package:example/utils/strings.dart';
import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

class JSONDataTableExample extends StatefulWidget {
  const JSONDataTableExample({super.key});

  @override
  State<JSONDataTableExample> createState() => _JSONDataTableExampleState();
}

class _JSONDataTableExampleState extends State<JSONDataTableExample> {
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
      appBar: const TableAppBar(
        title: AppStrings.jsonDataTableTitle,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          FlutterMultiScrollTable(
            totalWidth: 900,
            height: 480,
            headerTextStyle: headerTextStyle,
            jsonDataList: CommonUtils.jsonDataList,
            fixedCount: 1,
          ),
        ],
      ),
    );
  }
}
