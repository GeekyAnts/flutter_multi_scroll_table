import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/flutter_multi_scroll_table.dart';
import 'package:flutter_multi_scroll_table/src/component/each_cell.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: FlutterMultiScrollTable(
        totalWidth: 700,
        fixedColumnWidth: 80,
        height: 500,
        scrollableColumnChildren: List.generate(
            20,
            (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        EachCell(
                          text: "Vipul Chaurasia",
                          width: 105,
                          // height: 60,
                        ),
                        EachCell(
                          text: "B",
                          width: 50,
                        ),
                        EachCell(
                          text: "C",
                          width: 50,
                        ),
                        EachCell(
                          text: "D",
                          width: 50,
                        ),
                        EachCell(
                          text: "E",
                          width: 50,
                        ),
                        EachCell(
                          text: "F",
                          width: 50,
                        ),
                        EachCell(
                          text: "G",
                          width: 50,
                        ),
                        EachCell(
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
                        color: Colors.grey,
                        height: 1,
                      ),
                    ),
                  ],
                )),
        fixedColumnChildren: List.generate(
            20,
            (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EachCell(
                      text: "C",
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
                )),
        fixedColumnName: "S.no",
        columns: const [
          EachCell(
            text: "Member",
            width: 105,
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
      ),
    );
  }
}
