import 'package:flutter/material.dart';
import '../../flutter_multi_scroll_table.dart';

class ResizeableColumn extends StatefulWidget {
  final double initialWidth;
  final Widget header;
  final List<Widget> children;
  final bool isExpandable;
  final bool isFixed;
  final Widget? draggableIcon;
  final double maxWidth;
  final double availableWidth;
  final double? tableDividerThickness;
  final Color? tableDividerColor;
  final Function(double) onWidthChanged;
  final VoidCallback? onSortColumn;

  const ResizeableColumn({
    Key? key,
    required this.initialWidth,
    required this.header,
    required this.children,
    required this.isExpandable,
    this.isFixed = false,
    this.draggableIcon,
    required this.maxWidth,
    required this.availableWidth,
    required this.onWidthChanged,
    this.tableDividerThickness,
    this.tableDividerColor,
    this.onSortColumn,
  }) : super(key: key);

  @override
  State<ResizeableColumn> createState() => _ResizeableColumnState();
}

class _ResizeableColumnState extends State<ResizeableColumn> {
  late double _width;

  @override
  void initState() {
    super.initState();
    _width = widget.initialWidth;
  }

  @override
  Widget build(BuildContext context) {
    Color? headerBackgroundColor;
    Color? dataBackgroundColor;

    if (widget.header is EachCell) {
      final eachCellHeader = widget.header as EachCell;
      headerBackgroundColor = eachCellHeader.headerBackgroundColor;
      dataBackgroundColor = eachCellHeader.dataBackgroundColor;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _width,
          child: Column(
            children: [
              GestureDetector(
                onTap: widget.onSortColumn,
                child: Container(
                  color: headerBackgroundColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: widget.header is EachCell
                            ? (widget.header as EachCell)
                                .copyWith(width: _width)
                            : widget.header,
                      ),
                      if (widget.isExpandable)
                        MouseRegion(
                          cursor: SystemMouseCursors.resizeLeftRight,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onHorizontalDragUpdate: (details) {
                              setState(() {
                                final newWidth = _width + details.delta.dx;

                                if (widget.isFixed) {
                                  if (newWidth >= widget.initialWidth &&
                                      newWidth <= widget.availableWidth) {
                                    _width = newWidth;
                                    widget.onWidthChanged(details.delta.dx);
                                  } else if (newWidth < widget.initialWidth) {
                                    _width = widget.initialWidth;
                                  }
                                } else if (newWidth >= widget.initialWidth) {
                                  _width = newWidth;
                                }
                              });
                            },
                            child: widget.draggableIcon ??
                                const Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                thickness: widget.tableDividerThickness,
                color: widget.tableDividerColor,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children.map((child) {
            return SizedBox(
              width: _width,
              child: child is EachCell
                  ? child.copyWith(
                      width: _width,
                      dataBackgroundColor: dataBackgroundColor,
                    )
                  : child,
            );
          }).toList(),
        ),
      ],
    );
  }
}
