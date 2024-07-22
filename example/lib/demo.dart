import 'package:example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';
import 'package:flutter_multi_scroll_table/src/component/each_cell.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final List<int> _numbers = List.generate(20, (index) => index + 1)..shuffle();

  final List<String> _randomAlphabets =
      List.generate(20, (_) => CommonUtils.generateRandomAlphabet());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 900,
        height: 500,
        fixedColumnHeader: const [
          EachCell(
            text: "Sr. No",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "Random",
            width: 80,
            isHeader: true,
          ),
        ],
        fixedColumnChildren: [
          _numbers.map((number) {
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
          _randomAlphabets.map((number) {
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
        scrollableColumnChildren: [
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.names[index],
                  width: 100,
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
          List.generate(
            20,
            (index) => Column(
              children: [
                EachCell(
                  text: CommonUtils.cities[index],
                  width: 100,
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
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.fruits[index],
                  width: 100,
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
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.carBrands[index],
                  width: 100,
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
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.countries[index],
                  width: 100,
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
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EachCell(
                  text: CommonUtils.countryCodes[index],
                  width: 100,
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
        ],
        scrollableColumnHeader: const [
          EachCell(
            text: "Members",
            width: 100,
            isHeader: true,
          ),
          EachCell(
            text: "Cities",
            width: 100,
            isHeader: true,
          ),
          EachCell(
            text: "Fruits",
            width: 100,
            isHeader: true,
          ),
          EachCell(
            text: "Cars",
            width: 100,
            isHeader: true,
          ),
          EachCell(
            text: "Countries",
            width: 100,
            isHeader: true,
          ),
          EachCell(
            text: "Codes",
            width: 100,
            isHeader: true,
          ),
        ],
      ),
    );
  }
}
