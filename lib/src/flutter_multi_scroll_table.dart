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
  final void Function(int, List<EachCell>)? onGenerateRowConfiguration;

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
    this.onGenerateRowConfiguration,
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

  // Store styles for EachCell
  final Map<int, Map<int, EachCell>> _rowConfigurations = {};

  @override
  void initState() {
    _horizontalScrollController = ScrollController();
    _headerScrollController = ScrollController();
    _verticalScrollController = ScrollController();

    _horizontalScrollController.addListener(_syncHorizontalScroll);
    _headerScrollController.addListener(_syncHeaderScroll);
    _sortHeadersByPriority();

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

  void _applyRowConfigurations(List<List<EachCell>> columnChildren) {
    for (int rowIndex = 0; rowIndex < columnChildren[0].length; rowIndex++) {
      if (widget.onGenerateRowConfiguration != null) {
        List<EachCell> rowChildren =
            columnChildren.map((col) => col[rowIndex]).toList();

        // Apply configurations
        widget.onGenerateRowConfiguration!(
          rowIndex,
          rowChildren,
        );

        // Extract and store row configurations
        _rowConfigurations[rowIndex] = {};
        for (int colIndex = 0; colIndex < rowChildren.length; colIndex++) {
          _rowConfigurations[rowIndex]![colIndex] = rowChildren[colIndex];
        }
      }
    }
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
        for (int j = 0; j < widget.columnChildren[i].length; j++) {
          dynamic data = widget.columnChildren[i][j];
          String text = data.toString();
          EachCell cell = EachCell(
            text: text,
            width: width,
            height: height,
            dataTextStyle: textStyle,
            dataBackgroundColor: backgroundColor,
          );
          column.add(cell);
        }
      }
      styledColumnChildren.add(column);
    }

    // Apply row configurations here
    _applyRowConfigurations(styledColumnChildren);

    return styledColumnChildren;
  }

  void _sortHeadersByPriority() {
    // Initialize lists to hold headers with set priorities and those without
    List<MapEntry<EachCell, List<dynamic>>> prioritizedHeaders = [];
    List<MapEntry<EachCell, List<dynamic>>> unprioritizedHeaders = [];

    // Separate headers based on whether they have a set priority or not
    for (int i = 0; i < widget.headers.length; i++) {
      if (widget.headers[i].priority != null) {
        prioritizedHeaders
            .add(MapEntry(widget.headers[i], widget.columnChildren[i]));
      } else {
        unprioritizedHeaders
            .add(MapEntry(widget.headers[i], widget.columnChildren[i]));
      }
    }

    // Sort the prioritized headers based on their priority value
    prioritizedHeaders
        .sort((a, b) => a.key.priority!.compareTo(b.key.priority!));

    // Create a list to hold the combined headers and columns with enough space
    List<MapEntry<EachCell, List<dynamic>>> combined = List.filled(
      widget.headers.length,
      const MapEntry<EachCell, List<dynamic>>(
          EachCell(
            text: '',
          ),
          []),
    );

    // Add prioritized headers to the combined list
    for (var entry in prioritizedHeaders) {
      int priorityIndex = entry.key.priority!;
      // Ensure we don't exceed the bounds of the combined list
      if (priorityIndex < combined.length) {
        combined[priorityIndex] = entry;
      }
    }

    // Fill in the gaps with unprioritized headers in their natural order
    int currentIndex = 0;
    for (var entry in unprioritizedHeaders) {
      // Skip over any indices that have already been filled
      while (currentIndex < combined.length &&
          combined[currentIndex].key.text.isNotEmpty) {
        currentIndex++;
      }
      // Add unprioritized entries to the next available spot
      if (currentIndex < combined.length) {
        combined[currentIndex] = entry;
      } else {
        combined.add(entry);
      }
      currentIndex++;
    }

    //  Clear the original headers and columnChildren lists
    widget.headers.clear();
    widget.columnChildren.clear();

    // Add the combined entries back to the headers and columnChildren lists
    for (var entry in combined) {
      if (entry.key.text.isNotEmpty) {
        // Ensure we are not adding placeholder entries
        widget.headers.add(entry.key);
        widget.columnChildren.add(entry.value);
      }
    }

    //  Update the state to reflect the sorted order
    setState(() {});
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

    final List<List<EachCell>> styledColumnChildren =
        _generateColumnChildrenWithStyles();

    // Apply onGenerateRowConfiguration for each row
    for (int rowIndex = 0;
        rowIndex < styledColumnChildren[0].length;
        rowIndex++) {
      if (widget.onGenerateRowConfiguration != null) {
        List<EachCell> rowChildren =
            styledColumnChildren.map((col) => col[rowIndex]).toList();

        widget.onGenerateRowConfiguration!(
          rowIndex,
          rowChildren,
        );
      }
    }

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
                                  // Get the row index and column index for the child
                                  final columnIndex = styledColumnChildren
                                      .indexOf(styledColumnChildren.firstWhere(
                                          (col) => col.contains(child)));
                                  final rowIndex = styledColumnChildren
                                      .firstWhere((col) => col.contains(child))
                                      .indexOf(child);

                                  // Apply styles from _rowConfigurations
                                  final rowConfig =
                                      _rowConfigurations[rowIndex];
                                  final EachCell? rowCell =
                                      rowConfig?[columnIndex];

                                  return Column(
                                    children: [
                                      child.copyWith(
                                        dataBackgroundColor:
                                            rowCell?.dataBackgroundColor,
                                        headerBackgroundColor:
                                            rowCell?.headerBackgroundColor,
                                        dataTextStyle: rowCell?.dataTextStyle,
                                        width: rowCell?.width ?? child.width,
                                        height: rowCell?.height ?? child.height,
                                      ),
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
                                          // Get the row index and column index for the child
                                          final columnIndex =
                                              styledColumnChildren.indexOf(
                                                  styledColumnChildren
                                                      .firstWhere((col) =>
                                                          col.contains(child)));
                                          final rowIndex = styledColumnChildren
                                              .firstWhere(
                                                  (col) => col.contains(child))
                                              .indexOf(child);

                                          // Apply styles from _rowConfigurations
                                          final rowConfig =
                                              _rowConfigurations[rowIndex];
                                          final EachCell? rowCell =
                                              rowConfig?[columnIndex];

                                          return Column(
                                            children: [
                                              child.copyWith(
                                                dataBackgroundColor: rowCell
                                                    ?.dataBackgroundColor,
                                                dataTextStyle:
                                                    rowCell?.dataTextStyle,
                                                width: rowCell?.width ??
                                                    child.width,
                                                height: rowCell?.height ??
                                                    child.height,
                                              ),
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
