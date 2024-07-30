import 'package:flutter/material.dart';

/// A widget that represents a fixed column in a table.
/// It displays a list of widgets in a vertical column with a fixed width.
class FixedColumn extends StatelessWidget {
  /// The width of the fixed column.
  final double width;

  /// The list of widgets to be displayed in the fixed column.
  final List<Widget> fixedColumns;

  /// Creates a [FixedColumn] widget.
  ///
  /// The [width] and [fixedColumns] parameters must not be null.
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
      ),
    );
  }
}
