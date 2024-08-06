import 'package:flutter/material.dart';
import '../flutter_multi_scroll_table.dart';

/// A widget that displays a multi-scrollable table with fixed and scrollable columns.
class FlutterMultiScrollTable extends StatefulWidget {
  /// The header widgets for the columns.
  final List<Widget> headers;

  /// The children widgets for the columns.
  final List<List<Widget>> columnChildren;

  /// The number of fixed columns.
  final int fixedCount;

  /// The total width of the table.
  final double totalWidth;

  /// The height of the table. Default is 500.
  final double? height;

  /// Whether the sorting is in ascending order. Default is true.
  final bool isAscending;

  /// The border for the table.
  final BoxBorder? tableBorder;

  /// [draggableIcon] is the icon displayed for dragging the column width.
  final Widget? draggableIcon;

  /// Creates a [FlutterMultiScrollTable] widget.
  const FlutterMultiScrollTable({
    super.key,
    required this.headers,
    required this.columnChildren,
    required this.fixedCount,
    required this.totalWidth,
    this.height = 500,
    this.isAscending = true,
    this.tableBorder,
    this.draggableIcon,
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
      for (int i = 0; i < widget.fixedCount; i++) {
        widget.columnChildren[i].sort((a, b) {
          final textA = Utils.getTextFromWidget(a);
          final textB = Utils.getTextFromWidget(b);
          final comparisonResult = Utils.compareTexts(textA, textB);
          return widget.isAscending ? comparisonResult : -comparisonResult;
        });
      }

      // Sort all scrollable columns
      for (int i = widget.fixedCount; i < widget.columnChildren.length; i++) {
        widget.columnChildren[i].sort((a, b) {
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
    double adjustedHeight =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.height *
                0.8 // Adjust this value as needed
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
                          children: widget.headers
                              .take(widget.fixedCount)
                              .map((header) {
                            final eachCell = header as EachCell;

                            return ResizableColumn(
                              initialWidth: eachCell.width ?? 100,
                              header: header,
                              isExpandable: eachCell.isExpandable,
                              isFixed: true,
                              draggableIcon: widget.draggableIcon,
                              children: widget.columnChildren[
                                      widget.headers.indexOf(header)]
                                  .map((child) {
                                return Column(
                                  children: [
                                    child,
                                    const Divider(height: 1),
                                  ],
                                );
                              }).toList(),
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
                                  children: widget.headers
                                      .skip(widget.fixedCount)
                                      .map((header) {
                                    final eachCell = header as EachCell;

                                    return ResizableColumn(
                                      initialWidth: eachCell.width ?? 100,
                                      header: header,
                                      isExpandable: eachCell.isExpandable,
                                      draggableIcon: widget.draggableIcon,
                                      children: widget.columnChildren[
                                              widget.headers.indexOf(header)]
                                          .map((child) {
                                        return Column(
                                          children: [
                                            child,
                                            const Divider(height: 1),
                                          ],
                                        );
                                      }).toList(),
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
