import 'package:flutter/material.dart';
import '../../flutter_multi_scroll_table.dart';

class ResizableColumn extends StatefulWidget {
  final double initialWidth;
  final Widget header;
  final List<Widget> children;
  final bool isExpandable;
  final bool isFixed;
  final Widget? draggableIcon;

  const ResizableColumn({
    Key? key,
    required this.initialWidth,
    required this.header,
    required this.children,
    required this.isExpandable,
    this.isFixed = false,
    this.draggableIcon,
  }) : super(key: key);

  @override
  State<ResizableColumn> createState() => _ResizableColumnState();
}

class _ResizableColumnState extends State<ResizableColumn> {
  late double _width;

  @override
  void initState() {
    super.initState();
    _width = widget.initialWidth;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _width,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: widget.header is EachCell
                        ? (widget.header as EachCell).copyWith(width: _width)
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
                              // Ensure the width does not exceed the screen width and is not less than the initial width when isFixed is true
                              if (newWidth >= widget.initialWidth &&
                                  newWidth <= screenWidth) {
                                _width = newWidth;
                              } else if (newWidth > screenWidth) {
                                _width = screenWidth;
                              } else if (newWidth < widget.initialWidth) {
                                _width = widget.initialWidth;
                              }
                            } else {
                              // Ensure the width is not less than the initial width when isFixed is false
                              if (newWidth >= widget.initialWidth) {
                                _width = newWidth;
                              } else {
                                _width = widget.initialWidth;
                              }
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
              const Divider(
                height: 1,
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
                  ? (child).copyWith(
                      width: _width,
                    )
                  : child,
            );
          }).toList(),
        ),
      ],
    );
  }
}
