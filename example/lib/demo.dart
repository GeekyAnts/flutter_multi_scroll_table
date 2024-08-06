import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';

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
    // Combine headers into a single list
    final headers = [
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
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random 1",
        width: 100,
        textStyle: headerTextStyle,
        isHeader: true,
      ),
      EachCell(
        text: "Random 2",
        width: 100,
        textStyle: headerTextStyle,
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
    ];

    final columnChildren = [
      _numbers.map((number) {
        return EachCell(
          text: number.toString(),
          width: 80,
          height: 45,
        );
      }).toList(),
      _randomAlphabets.map((number) {
        return EachCell(
          text: number.toString(),
          width: 90,
          height: 45,
        );
      }).toList(),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.names[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.cities[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.fruits[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.carBrands[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countries[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
      List.generate(
        20,
        (index) => EachCell(
          text: CommonUtils.countryCodes[index],
          width: 100,
          height: 45,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 900,
        height: 480,
        headers: headers,
        columnChildren: columnChildren,
        fixedCount: 2,
      ),
    );
  }
}
