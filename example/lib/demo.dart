import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';
import 'package:flutter_multi_scroll_table/src/component/each_cell.dart';

import 'utils/utils.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 700,
        height: 500,
        scrollableColumnChildren: List.generate(
          20,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  EachCell(
                    text: Utils.names[index],
                    width: 120,
                    // height: 60,
                  ),
                  const EachCell(
                    text: "B",
                    width: 50,
                  ),
                  const EachCell(
                    text: "C",
                    width: 50,
                  ),
                  const EachCell(
                    text: "D",
                    width: 50,
                  ),
                  const EachCell(
                    text: "E",
                    width: 50,
                  ),
                  const EachCell(
                    text: "F",
                    width: 50,
                  ),
                  const EachCell(
                    text: "G",
                    width: 50,
                  ),
                  const EachCell(
                    text: "H",
                    width: 50,
                  )
                ],
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2),
                width: 600 - 60,
                child: const Divider(
                  height: 1,
                ),
              ),
            ],
          ),
        ),
        fixedColumnChildren: [
          Utils.srNumbers.map((number) {
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
          List.generate(
            20,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EachCell(
                  text: "Y",
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
            ),
          ),
          Utils.numbers.map((number) {
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
        fixedColumnTitles: const ["S.no", 'A', 'B'],
        columns: const [
          EachCell(
            text: "Members",
            width: 120,
            isHeader: true,
          ),
          EachCell(
            text: "A",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "B",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "C",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "D",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "E",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "F",
            width: 50,
            isHeader: true,
          ),
          EachCell(
            text: "G",
            width: 50,
            isHeader: true,
          ),
        ],
        fixedColumnWidths: const [40, 40, 40],
      ),
    );
  }
}
