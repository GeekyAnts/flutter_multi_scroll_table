import 'package:flutter/material.dart';

/// A widget that represents a scrollable column in a table.
/// It displays a list of widgets in a vertical column with an optional width.
class ScrollableColumn extends StatefulWidget {
  /// The width of the scrollable column.
  final double? width;

  /// The list of widgets to be displayed in the scrollable column.
  final List<Widget> scrollableColumns;

  /// Creates a [ScrollableColumn] widget.
  ///
  /// The [width] and [scrollableColumns] parameters must not be null.
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
      ),
    );
  }
}
