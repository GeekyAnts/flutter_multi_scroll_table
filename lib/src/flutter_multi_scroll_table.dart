import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/src/utils/utils.dart';
import '../flutter_multi_scroll_table.dart';

/// A widget that represents a multi-scrollable table with resizable columns.
class FlutterMultiScrollTable extends StatefulWidget {
  /// A list of header cells for the table. Each header is an `EachCell` widget.
  final List<EachCell>? headers;

  /// A list of maps where each map represents a row of data in JSON format.
  /// Each key in the map corresponds to a column header, and the value is the cell data.
  /// This is used to generate column data and headers if not explicitly provided.
  final List<Map<String, dynamic>>? jsonDataList;

  /// A 2D list where each inner list represents a row of data.
  /// Each element in the inner list represents a cell value in that row.
  /// This format is used to provide column data directly, assuming the column headers are already known.
  final List<List<dynamic>>? dataList;

  /// The number of columns that should remain fixed when horizontally scrolling.
  final int fixedCount;

  /// The total width of the table, including all columns.
  final double totalWidth;

  /// The height of the table. Defaults to 500 if not provided.
  final double? height;

  /// Indicates whether the columns should be sorted in ascending order.
  final bool isAscending;

  /// The text style to be applied to all the header cells.
  final TextStyle? headerTextStyle;

  /// The text style to be applied to all the data cells.
  final TextStyle? dataTextStyle;

  /// The background color to be applied to all header cells.
  final Color? headerBackgroundColor;

  /// The background color to be applied to all data cells.
  final Color? dataBackgroundColor;

  /// The border for the entire table. Defaults to a grey border if not provided.
  final BoxBorder? tableBorder;

  /// The thickness of the divider lines between table cells.
  /// If not provided, a default thickness will be used.
  final double? tableDividerThickness;

  /// The color of the divider lines between table cells.
  /// If not provided, a default color will be used.
  final Color? tableDividerColor;

  /// A custom widget to use as the draggable icon for resizing columns.
  final Widget? draggableIcon;

  /// A placeholder string that will be used to replace any missing or null data in the table.
  /// For example, if a data cell is empty or has a null value, this string will be displayed instead.
  final String? dataPlaceholder;

  /// A callback function that allows dynamic configuration of rows based on their index.
  /// It takes the row index and a list of `EachCell` widgets representing the row as parameters.
  final void Function(int, List<EachCell>)? onGenerateRowConfiguration;

  /// Creates a [FlutterMultiScrollTable] widget.
  const FlutterMultiScrollTable({
    super.key,
    this.headers,
    this.dataList,
    required this.fixedCount,
    required this.totalWidth,
    this.height = 500,
    this.isAscending = true,
    this.tableBorder,
    this.draggableIcon,
    this.onGenerateRowConfiguration,
    this.headerTextStyle,
    this.dataTextStyle,
    this.tableDividerThickness,
    this.tableDividerColor,
    this.jsonDataList,
    this.headerBackgroundColor,
    this.dataBackgroundColor,
    this.dataPlaceholder,
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

  double? adjustedHeight;

  // Store styles for EachCell
  final Map<int, Map<int, EachCell>> _rowConfigurations = {};

  late List<List<dynamic>> columnChildren;

  late List<EachCell>? jsonHeaders;

  @override
  void initState() {
    _initializeColumnChildren();

    // Use jsonHeaders if headers are not provided by the user
    final effectiveHeaders = widget.headers ?? jsonHeaders;

    if (effectiveHeaders == null) {
      throw FlutterError(
          'No headers provided. Either provide headers or jsonDataList to generate headers automatically.');
    }

    // Validate headers and column data
    if (columnChildren.length < effectiveHeaders.length) {
      throw FlutterError(
          'The number of column children provided (${columnChildren.length}) is less than the number of headers (${effectiveHeaders.length}). '
          'Please provide a column child for each header.');
    }

    _horizontalScrollController = ScrollController();
    _headerScrollController = ScrollController();
    _verticalScrollController = ScrollController();

    _horizontalScrollController.addListener(_syncHorizontalScroll);
    _headerScrollController.addListener(_syncHeaderScroll);
    _sortHeadersByPriority();

    super.initState();
  }

  void _initializeColumnChildren() {
    // Check if both jsonDataList and dataList are provided
    if (widget.jsonDataList != null && widget.dataList != null) {
      throw FlutterError(
          'Both jsonDataList and dataList cannot be provided simultaneously. Please provide only one dataList.');
    }

    // Convert input data to column-wise format
    if (widget.jsonDataList != null) {
      columnChildren = _convertToColumnWiseFromJson(widget.jsonDataList!);

      jsonHeaders = _generateHeadersFromJson(widget.jsonDataList!);
    } else if (widget.dataList != null) {
      if (widget.headers == null || widget.headers!.isEmpty) {
        throw FlutterError(
            'Headers are required when using dataList. Please provide headers.');
      }
      columnChildren = _convertToColumnWiseFromData(widget.dataList!);
    } else {
      throw FlutterError(
          'No data provided. Please provide either jsonDataList or dataList.');
    }
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

  List<EachCell> _generateHeadersFromJson(
      List<Map<String, dynamic>> jsonDataList) {
    if (jsonDataList.isEmpty) {
      return [];
    }

    final headers = jsonDataList.first.keys.toList();
    return headers.map((header) => EachCell(text: header)).toList();
  }

  double getTotalFixedWidth() {
    double totalWidth = 0;

    // Use widget.headers if available, otherwise fallback to jsonHeaders
    final effectiveHeaders = widget.headers ?? jsonHeaders;

    if (effectiveHeaders != null) {
      for (var header in effectiveHeaders.take(widget.fixedCount)) {
        totalWidth += header.width ?? 100;
      }
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

  List<List<dynamic>> _convertToColumnWiseFromJson(
      List<Map<String, dynamic>> jsonDataList) {
    if (jsonDataList.isEmpty) return [];

    final List<String> headers = jsonDataList.first.keys.toList();
    final List<List<dynamic>> columnWiseData =
        List.generate(headers.length, (_) => []);

    for (final map in jsonDataList) {
      for (int i = 0; i < headers.length; i++) {
        final value = map[headers[i]] ?? widget.dataPlaceholder ?? '--';
        columnWiseData[i].add(value);
      }
    }

    return columnWiseData;
  }

  List<List<dynamic>> _convertToColumnWiseFromData(
      List<List<dynamic>> dataList) {
    if (dataList.isEmpty) return [];

    // Determine the maximum number of columns across all rows
    final int numCols =
        dataList.map((row) => row.length).reduce((a, b) => a > b ? a : b);

    // Create a list of empty lists for each column
    final List<List<dynamic>> columnWiseData =
        List.generate(numCols, (_) => []);

    for (final row in dataList) {
      for (int colIndex = 0; colIndex < numCols; colIndex++) {
        // Add data or use dataPlaceholder if the column data is missing
        columnWiseData[colIndex].add(colIndex < row.length
            ? row[colIndex]
            : widget.dataPlaceholder ?? "--");
      }
    }

    return columnWiseData;
  }

  List<List<EachCell>> _generateColumnChildrenWithStyles() {
    List<List<EachCell>> styledColumnChildren = [];

    // Use widget.headers if available, otherwise fallback to jsonHeaders
    final effectiveHeaders = widget.headers ?? jsonHeaders;

    if (effectiveHeaders != null) {
      for (int i = 0; i < effectiveHeaders.length; i++) {
        List<EachCell> column = [];
        TextStyle? dataTextStyle = widget.dataTextStyle;

        Color? headerBackgroundColor =
            effectiveHeaders[i].headerBackgroundColor;
        Color? dataBackgroundColor = effectiveHeaders[i].dataBackgroundColor;
        double? width = effectiveHeaders[i].width;
        double? height = effectiveHeaders[i].height;

        if (i < columnChildren.length) {
          for (int j = 0; j < columnChildren[i].length; j++) {
            dynamic data = columnChildren[i][j];
            String text = data.toString();

            // Use headerTextStyle for the header row
            EachCell cell = EachCell(
              text: text,
              width: width,
              height: height,
              dataTextStyle: dataTextStyle,
              dataBackgroundColor: dataBackgroundColor,
              headerBackgroundColor: j == 0 ? headerBackgroundColor : null,
            );
            column.add(cell);
          }
        }
        styledColumnChildren.add(column);
      }

      // Apply row configurations here
      _applyRowConfigurations(styledColumnChildren);
    }

    return styledColumnChildren;
  }

  void _sortHeadersByPriority() {
    // Use widget.headers if available, otherwise fallback to jsonHeaders
    final effectiveHeaders = widget.headers ?? jsonHeaders;

    if (effectiveHeaders == null) {
      return; // Return early if no headers are available
    }

    // Initialize lists to hold headers with set priorities and those without
    List<MapEntry<EachCell, List<dynamic>>> prioritizedHeaders = [];
    List<MapEntry<EachCell, List<dynamic>>> unprioritizedHeaders = [];

    // Separate headers based on whether they have a set priority or not
    for (int i = 0; i < effectiveHeaders.length; i++) {
      if (effectiveHeaders[i].priority != null) {
        prioritizedHeaders
            .add(MapEntry(effectiveHeaders[i], columnChildren[i]));
      } else {
        unprioritizedHeaders
            .add(MapEntry(effectiveHeaders[i], columnChildren[i]));
      }
    }

    // Sort the prioritized headers based on their priority value
    prioritizedHeaders
        .sort((a, b) => a.key.priority!.compareTo(b.key.priority!));

    // Create a list to hold the combined headers and columns with enough space
    List<MapEntry<EachCell, List<dynamic>>> combined = List.filled(
      effectiveHeaders.length,
      const MapEntry<EachCell, List<dynamic>>(
        EachCell(text: ''),
        [],
      ),
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

    // Clear the original headers and columnChildren lists
    effectiveHeaders.clear();
    columnChildren.clear();

    // Add the combined entries back to the headers and columnChildren lists
    for (var entry in combined) {
      if (entry.key.text.isNotEmpty) {
        // Ensure we are not adding placeholder entries
        effectiveHeaders.add(entry.key);
        columnChildren.add(entry.value);
      }
    }

    // Update the state to reflect the sorted order if using widget.headers
    if (widget.headers != null) {
      setState(() {});
    }
  }

  void _sortColumn() {
    setState(() {
      for (int i = 0; i < widget.fixedCount; i++) {
        columnChildren[i].sort((a, b) {
          final textA = Utils.getTextFromWidget(
              a is EachCell ? a : EachCell(text: a.toString()));
          final textB = Utils.getTextFromWidget(
              b is EachCell ? b : EachCell(text: b.toString()));
          final comparisonResult = Utils.compareTexts(textA, textB);
          return widget.isAscending ? comparisonResult : -comparisonResult;
        });
      }

      for (int i = widget.fixedCount; i < columnChildren.length; i++) {
        columnChildren[i].sort((a, b) {
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
    if (!kIsWeb) {
      adjustedHeight =
          MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.8
              : widget.height ?? 500;
    } else {
      adjustedHeight = widget.height ?? 500;
    }

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
                        Row(
                          children: (widget.headers ?? jsonHeaders)!
                              .take(widget.fixedCount)
                              .map((header) {
                            final eachCell = header;

                            // Apply specific headerTextStyle if defined, otherwise use top-level headerTextStyle
                            final headerTextStyle = eachCell.headerTextStyle ??
                                widget.headerTextStyle;

                            final dataTextStyle =
                                eachCell.dataTextStyle ?? widget.dataTextStyle;

                            return ResizeableColumn(
                              initialWidth: eachCell.width ?? 100,
                              header: EachCell(
                                text: eachCell.text,
                                width: eachCell.width,
                                height: eachCell.height,
                                headerTextStyle: headerTextStyle,
                                isHeader: true,
                                headerBackgroundColor:
                                    eachCell.headerBackgroundColor ??
                                        widget.headerBackgroundColor,
                              ),
                              isExpandable: eachCell.isExpandable,
                              isFixed: true,
                              draggableIcon: widget.draggableIcon,
                              maxWidth: MediaQuery.of(context).size.width,
                              availableWidth: _remainingWidth,
                              onWidthChanged: _onWidthChanged,
                              onSortColumn: _sortColumn,
                              tableDividerThickness:
                                  widget.tableDividerThickness,
                              tableDividerColor: widget.tableDividerColor,
                              children: styledColumnChildren[
                                      (widget.headers ?? jsonHeaders)!
                                          .indexOf(header)]
                                  .asMap()
                                  .map((index, child) {
                                    // Get the row index and column index for the child
                                    final columnIndex =
                                        styledColumnChildren.indexOf(
                                      styledColumnChildren.firstWhere(
                                          (col) => col.contains(child)),
                                    );
                                    final rowIndex = styledColumnChildren
                                        .firstWhere(
                                            (col) => col.contains(child))
                                        .indexOf(child);

                                    // Apply styles from _rowConfigurations
                                    final rowConfig =
                                        _rowConfigurations[rowIndex];
                                    final EachCell? rowCell =
                                        rowConfig?[columnIndex];

                                    return MapEntry(
                                      index,
                                      Column(
                                        children: [
                                          child.copyWith(
                                            dataBackgroundColor:
                                                rowCell?.dataBackgroundColor ??
                                                    widget.dataBackgroundColor,
                                            dataTextStyle:
                                                rowCell?.dataTextStyle ??
                                                    dataTextStyle,
                                            width:
                                                rowCell?.width ?? child.width,
                                            height:
                                                rowCell?.height ?? child.height,
                                          ),
                                          if (index <
                                              styledColumnChildren[
                                                          (widget.headers ??
                                                                  jsonHeaders)!
                                                              .indexOf(header)]
                                                      .length -
                                                  1)
                                            Divider(
                                              height: 1,
                                              thickness:
                                                  widget.tableDividerThickness,
                                              color: widget.tableDividerColor,
                                            ),
                                        ],
                                      ),
                                    );
                                  })
                                  .values
                                  .toList(),
                            );
                          }).toList(),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: _horizontalScrollController,
                                child: Row(
                                  children: (widget.headers ?? jsonHeaders)!
                                      .skip(widget.fixedCount)
                                      .map((header) {
                                    final eachCell = header;

                                    // Apply specific headerTextStyle if defined, otherwise use top-level headerTextStyle
                                    final headerTextStyle =
                                        eachCell.headerTextStyle ??
                                            widget.headerTextStyle;

                                    final dataTextStyle =
                                        eachCell.dataTextStyle ??
                                            widget.dataTextStyle;

                                    return ResizeableColumn(
                                      initialWidth: eachCell.width ?? 100,
                                      header: EachCell(
                                        text: eachCell.text,
                                        width: eachCell.width,
                                        height: eachCell.height,
                                        isHeader: true,
                                        headerTextStyle: headerTextStyle,
                                        headerBackgroundColor:
                                            eachCell.headerBackgroundColor ??
                                                widget.headerBackgroundColor,
                                      ),
                                      isExpandable: eachCell.isExpandable,
                                      draggableIcon: widget.draggableIcon,
                                      maxWidth:
                                          MediaQuery.of(context).size.width,
                                      availableWidth: _remainingWidth,
                                      tableDividerThickness:
                                          widget.tableDividerThickness,
                                      tableDividerColor:
                                          widget.tableDividerColor,
                                      onWidthChanged: _onWidthChanged,
                                      onSortColumn: _sortColumn,
                                      children: styledColumnChildren[
                                              (widget.headers ?? jsonHeaders)!
                                                  .indexOf(header)]
                                          .asMap()
                                          .map((index, child) {
                                            // Get the row index and column index for the child
                                            final columnIndex =
                                                styledColumnChildren.indexOf(
                                              styledColumnChildren.firstWhere(
                                                  (col) => col.contains(child)),
                                            );
                                            final rowIndex =
                                                styledColumnChildren
                                                    .firstWhere((col) =>
                                                        col.contains(child))
                                                    .indexOf(child);

                                            // Apply styles from _rowConfigurations
                                            final rowConfig =
                                                _rowConfigurations[rowIndex];
                                            final EachCell? rowCell =
                                                rowConfig?[columnIndex];

                                            return MapEntry(
                                              index,
                                              Column(
                                                children: [
                                                  child.copyWith(
                                                    dataBackgroundColor: rowCell
                                                            ?.dataBackgroundColor ??
                                                        widget
                                                            .dataBackgroundColor,
                                                    dataTextStyle: rowCell
                                                            ?.dataTextStyle ??
                                                        dataTextStyle,
                                                    width: rowCell?.width ??
                                                        child.width,
                                                    height: rowCell?.height ??
                                                        child.height,
                                                  ),
                                                  if (index <
                                                      styledColumnChildren[(widget
                                                                          .headers ??
                                                                      jsonHeaders)!
                                                                  .indexOf(
                                                                      header)]
                                                              .length -
                                                          1)
                                                    Divider(
                                                      height: 1,
                                                      thickness: widget
                                                          .tableDividerThickness,
                                                      color: widget
                                                          .tableDividerColor,
                                                    ),
                                                ],
                                              ),
                                            );
                                          })
                                          .values
                                          .toList(),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
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
