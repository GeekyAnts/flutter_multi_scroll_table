import 'package:flutter/material.dart';

class FixedColumn extends StatelessWidget {
  final double width;

  final List<Widget> fixedColumns;

  const FixedColumn({
    Key? key,
    required this.width,
    required this.fixedColumns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [...fixedColumns],
        ));
  }
}
