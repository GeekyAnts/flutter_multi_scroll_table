import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/src/component/each_cell.dart';
import 'package:flutter_multi_scroll_table/src/utils/utils.dart';

/// A widget that displays a multi-scrollable table with fixed and scrollable columns.
class FlutterMultiScrollTable extends StatefulWidget {
  /// The header widgets for the scrollable columns.
  final List<Widget> scrollableColumnHeader;

  /// The children widgets for the scrollable columns.
  final List<List<Widget>> scrollableColumnChildren;

  /// The header widgets for the fixed columns.
  final List<Widget> fixedColumnHeader;

  /// The children widgets for the fixed columns.
  final List<List<Widget>> fixedColumnChildren;

  /// The total width of the table.
  final double totalWidth;

  /// The height of the table. Default is 500.
  final double? height;

  /// Whether the sorting is in ascending order. Default is true.
  final bool isAscending;

  /// The border for the table.
  final BoxBorder? tableBorder;

  /// Creates a [FlutterMultiScrollTable] widget.
  const FlutterMultiScrollTable({
    super.key,
    required this.scrollableColumnHeader,
    required this.totalWidth,
    this.height = 500,
    required this.scrollableColumnChildren,
    required this.fixedColumnChildren,
    this.isAscending = true,
    required this.fixedColumnHeader,
    this.tableBorder,
  });

  @override
  State<FlutterMultiScrollTable> createState() =>
      _FlutterMultiScrollTableState();
}

class _FlutterMultiScrollTableState extends State<FlutterMultiScrollTable> {
  late ScrollController _horizontalScrollController;
  late ScrollController _headerScrollController;
  late ScrollController _verticalScrollController;
  bool _isHorizontalScrolling = false;
  bool _isHeaderScrolling = false;

  @override
  void initState() {
    _horizontalScrollController = ScrollController();
    _headerScrollController = ScrollController();
    _verticalScrollController = ScrollController();

    _horizontalScrollController.addListener(_syncHorizontalScroll);
    _headerScrollController.addListener(_syncHeaderScroll);
    super.initState();
  }

  /// Synchronizes the horizontal scroll position between the table body and the header.
  void _syncHorizontalScroll() {
    if (_isHeaderScrolling) return;

    _isHorizontalScrolling = true;

    if (_horizontalScrollController.hasClients &&
        _headerScrollController.hasClients) {
      _headerScrollController.jumpTo(_horizontalScrollController.offset);
    }

    _isHorizontalScrolling = false;
  }

  /// Synchronizes the header scroll position with the horizontal scroll position of the table body.
  void _syncHeaderScroll() {
    if (_isHorizontalScrolling) return;

    _isHeaderScrolling = true;

    if (_headerScrollController.hasClients &&
        _horizontalScrollController.hasClients) {
      _horizontalScrollController.jumpTo(_headerScrollController.offset);
    }

    _isHeaderScrolling = false;
  }

  /// Sorts the columns based on the text content.
  void _sortColumn() {
    setState(() {
      // Sort all fixed columns
      for (int i = 0; i < widget.fixedColumnChildren.length; i++) {
        widget.fixedColumnChildren[i].sort((a, b) {
          final textA = Utils.getTextFromWidget(a);
          final textB = Utils.getTextFromWidget(b);
          final comparisonResult = Utils.compareTexts(textA, textB);
          return widget.isAscending ? comparisonResult : -comparisonResult;
        });
      }

      // Sort all scrollable columns
      for (int i = 0; i < widget.scrollableColumnChildren.length; i++) {
        widget.scrollableColumnChildren[i].sort((a, b) {
          final textA = Utils.getTextFromWidget(a);
          final textB = Utils.getTextFromWidget(b);
          final comparisonResult = Utils.compareTexts(textA, textB);
          return widget.isAscending ? comparisonResult : -comparisonResult;
        });
      }
    });
  }

  @override
  void dispose() {
    _horizontalScrollController.removeListener(_syncHorizontalScroll);
    _headerScrollController.removeListener(_syncHeaderScroll);

    _horizontalScrollController.dispose();
    _headerScrollController.dispose();
    _verticalScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate totalFixedWidth from fixedColumnHeader
    // double totalFixedWidth = 0;
    // for (var cell in widget.fixedColumnHeader) {
    //   if (cell is EachCell) {
    //     totalFixedWidth += cell.width ?? 0.0;
    //   }
    // }

    // Adjust height based on orientation
    double adjustedHeight =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.height *
                0.7 // Adjust this value as needed
            : widget.height ?? 500;

    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: widget.tableBorder ??
                Border.all(width: 0.6, color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     GestureDetector(
              //       onTap: _sortColumn,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: widget.fixedColumnHeader.map((header) {
              //           final eachCell = header as EachCell;
              //           return ResizableColumn(
              //             initialWidth: eachCell.width ?? 100,
              //             header: header,
              //             children: widget.fixedColumnChildren[
              //                 widget.fixedColumnHeader.indexOf(header)],
              //           );
              //         }).toList(),
              //       ),
              //     ),
              //     Flexible(
              //       fit: FlexFit.loose,
              //       child: GestureDetector(
              //         onTap: _sortColumn,
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             SingleChildScrollView(
              //               physics: const BouncingScrollPhysics(),
              //               key: const Key("header"),
              //               scrollDirection: Axis.horizontal,
              //               controller: _headerScrollController,
              //               child: Row(
              //                 children:
              //                     widget.scrollableColumnHeader.map((header) {
              //                   final eachCell = header as EachCell;
              //                   return ResizableColumn(
              //                     initialWidth: eachCell.width ?? 100,
              //                     header: header,
              //                     children: widget.scrollableColumnChildren[
              //                         widget.scrollableColumnHeader
              //                             .indexOf(header)],
              //                   );
              //                 }).toList(),
              //               ),
              //             ),
              //             const SizedBox(height: 5),
              //             Container(
              //               padding: const EdgeInsets.symmetric(vertical: 2),
              //               width: double.infinity,
              //               child: const Divider(
              //                 height: 1,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // NEw
              SizedBox(
                height: adjustedHeight,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  key: const Key("data"),
                  scrollDirection: Axis.vertical,
                  controller: _verticalScrollController,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _sortColumn,
                        child: Row(
                          children: widget.fixedColumnHeader.map((header) {
                            final eachCell = header as EachCell;
                            return ResizableColumn(
                              initialWidth: eachCell.width ?? 100,
                              header: header,
                              children: widget.fixedColumnChildren[
                                  widget.fixedColumnHeader.indexOf(header)],
                            );
                          }).toList(),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: _sortColumn,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: _horizontalScrollController,
                                child: Row(
                                  children: widget.scrollableColumnHeader
                                      .map((header) {
                                    final eachCell = header as EachCell;

                                    print(eachCell.width);
                                    return ResizableColumn(
                                      initialWidth: eachCell.width ?? 100,
                                      header: header,
                                      children: widget.scrollableColumnChildren[
                                          widget.scrollableColumnHeader
                                              .indexOf(header)],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResizableColumn extends StatefulWidget {
  final double initialWidth;
  final Widget header;
  final List<Widget> children;

  const ResizableColumn({
    Key? key,
    required this.initialWidth,
    required this.header,
    required this.children,
  }) : super(key: key);

  @override
  _ResizableColumnState createState() => _ResizableColumnState();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _width,
          child: widget.header is EachCell
              ? (widget.header as EachCell).copyWith(width: _width)
              : widget.header,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.resizeLeftRight,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragUpdate: (details) {
              setState(() {
                final newWidth = _width + details.delta.dx;
                if (newWidth >= widget.initialWidth) {
                  _width = newWidth;
                }
              });
            },
            child: const Icon(
              Icons.chevron_right,
              size: 12,
              color: Colors.red,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children.map((child) {
            return SizedBox(
              width: _width,
              child:
                  child is EachCell ? (child).copyWith(width: _width) : child,
            );
          }).toList(),
        ),
      ],
    );
  }
}
