import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/src/utils/utils.dart';

import '../flutter_multi_scroll_table.dart';

class FlutterMultiScrollTable extends StatefulWidget {
  final List<EachCell> headers;
  final List<List<dynamic>> columnChildren;
  final int fixedCount;
  final double totalWidth;
  final double? height;
  final bool isAscending;
  final BoxBorder? tableBorder;
  final Widget? draggableIcon;

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
  final bool _isHeaderScrolling = false;

  double _remainingWidth = 0;

  @override
  void initState() {
    _horizontalScrollController = ScrollController();
    _headerScrollController = ScrollController();
    _verticalScrollController = ScrollController();

    _horizontalScrollController.addListener(_syncHorizontalScroll);
    _headerScrollController.addListener(_syncHeaderScroll);
    //  _sortHeadersByPriority();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateRemainingWidth();
  }

  void _syncHorizontalScroll() {
    if (_isHeaderScrolling) return;

    _isHorizontalScrolling = true;

    if (_horizontalScrollController.hasClients &&
        _headerScrollController.hasClients) {
      _headerScrollController.jumpTo(_horizontalScrollController.offset);
    }

    _isHorizontalScrolling = false;
  }

  void _syncHeaderScroll() {
    if (_isHorizontalScrolling) return;

    _isHorizontalScrolling = true;

    if (_headerScrollController.hasClients &&
        _horizontalScrollController.hasClients) {
      _horizontalScrollController.jumpTo(_headerScrollController.offset);
    }

    _isHorizontalScrolling = false;
  }

  double getTotalFixedWidth() {
    double totalWidth = 0;
    for (var header in widget.headers.take(widget.fixedCount)) {
      totalWidth += header.width ?? 100;
    }
    return totalWidth;
  }

  void _updateRemainingWidth() {
    double screenWidth = MediaQuery.of(context).size.width;
    double totalFixedWidth = getTotalFixedWidth();
    double usedWidth = widget.totalWidth - totalFixedWidth;

    setState(() {
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        _remainingWidth = screenWidth - usedWidth;
      } else {
        _remainingWidth = screenWidth - totalFixedWidth;
      }
    });
  }

  void _onWidthChanged(double widthChange) {
    setState(() {
      _updateRemainingWidth();
    });
  }

  List<List<EachCell>> _generateColumnChildrenWithStyles() {
    List<List<EachCell>> styledColumnChildren = [];

    for (int i = 0; i < widget.headers.length; i++) {
      List<EachCell> column = [];
      TextStyle? textStyle = widget.headers[i].dataTextStyle;
      Color? backgroundColor = widget.headers[i].dataBackgroundColor;
      double? width = widget.headers[i].width;
      double? height = widget.headers[i].height;

      if (i < widget.columnChildren.length) {
        for (dynamic data in widget.columnChildren[i]) {
          String text = data.toString();
          column.add(
            EachCell(
              text: text,
              width: width,
              height: height,
              dataTextStyle: textStyle,
              dataBackgroundColor: backgroundColor,
            ),
          );
        }
      }
      styledColumnChildren.add(column);
    }

    return styledColumnChildren;
  }

  void _sortHeadersByPriority() {
    List<MapEntry<EachCell, List<dynamic>>> headersWithColumns = [];

    for (int i = 0; i < widget.headers.length; i++) {
      headersWithColumns
          .add(MapEntry(widget.headers[i], widget.columnChildren[i]));
    }

    // Sort by priority, with null priorities treated as a large value (so they go last)
    headersWithColumns.sort((a, b) {
      int priorityA =
          a.key.priority ?? 9999; // default to a large value if null
      int priorityB = b.key.priority ?? 9999;
      return priorityA.compareTo(priorityB);
    });

    // Update headers and columnChildren in the widget
    setState(() {
      widget.headers
        ..clear()
        ..addAll(headersWithColumns.map((entry) => entry.key));
      widget.columnChildren
        ..clear()
        ..addAll(headersWithColumns.map((entry) => entry.value));
    });
  }

  void _sortColumn() {
    setState(() {
      for (int i = 0; i < widget.fixedCount; i++) {
        widget.columnChildren[i].sort((a, b) {
          final textA = Utils.getTextFromWidget(
              a is EachCell ? a : EachCell(text: a.toString()));
          final textB = Utils.getTextFromWidget(
              b is EachCell ? b : EachCell(text: b.toString()));
          final comparisonResult = Utils.compareTexts(textA, textB);
          return widget.isAscending ? comparisonResult : -comparisonResult;
        });
      }

      for (int i = widget.fixedCount; i < widget.columnChildren.length; i++) {
        widget.columnChildren[i].sort((a, b) {
          final textA = Utils.getTextFromWidget(
              a is EachCell ? a : EachCell(text: a.toString()));
          final textB = Utils.getTextFromWidget(
              b is EachCell ? b : EachCell(text: b.toString()));
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
            ? MediaQuery.of(context).size.height * 0.8
            : widget.height ?? 500;

    _updateRemainingWidth();

    final styledColumnChildren = _generateColumnChildrenWithStyles();

    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Container(
            width: widget.totalWidth,
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
                              final eachCell = header;

                              return ResizableColumn(
                                initialWidth: eachCell.width ?? 100,
                                header: header,
                                isExpandable: eachCell.isExpandable,
                                isFixed: true,
                                draggableIcon: widget.draggableIcon,
                                maxWidth: MediaQuery.of(context).size.width,
                                availableWidth: _remainingWidth,
                                onWidthChanged: _onWidthChanged,
                                children: styledColumnChildren[
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
                                      final eachCell = header;

                                      return ResizableColumn(
                                        initialWidth: eachCell.width ?? 100,
                                        header: header,
                                        isExpandable: eachCell.isExpandable,
                                        draggableIcon: widget.draggableIcon,
                                        maxWidth:
                                            MediaQuery.of(context).size.width,
                                        availableWidth: _remainingWidth,
                                        onWidthChanged: _onWidthChanged,
                                        children: styledColumnChildren[
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
      ),
    );
  }
}
