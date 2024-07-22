import 'package:flutter/material.dart';

class ScrollableColumn extends StatefulWidget {
  final double? width;
  final List<Widget> scrollableColumns;

  const ScrollableColumn({
    Key? key,
    required this.width,
    required this.scrollableColumns,
  }) : super(key: key);

  @override
  State<ScrollableColumn> createState() => _ScrollableColumnState();
}

class _ScrollableColumnState extends State<ScrollableColumn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [...widget.scrollableColumns],
        ));
  }
}
