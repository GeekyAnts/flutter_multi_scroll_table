import 'package:flutter/material.dart';

class FixedColumn extends StatelessWidget {
  final double width;

  final List<Widget> rows;
  final String? fixedColumnName;

  const FixedColumn({
    Key? key,
    required this.width,
    required this.rows,
    this.fixedColumnName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // SizedBox(
        //   width: width,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       XYCell(
        //         text: fixedColumnName ?? "",
        //         height: 45,
        //         isHeader: true,
        //         width: width,
        //       ),
        //       const SizedBox(height: 5),
        //       Container(
        //         padding: const EdgeInsets.symmetric(vertical: 2),
        //         child: const Divider(
        //           height: 1,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...rows],
            ))
      ],
    );
  }
}
