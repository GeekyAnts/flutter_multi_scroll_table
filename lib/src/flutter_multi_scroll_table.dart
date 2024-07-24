import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/src/component/each_cell.dart';
import 'package:flutter_multi_scroll_table/src/utils/utils.dart';
import 'component/fixed_column.dart';
import 'component/scrollable_column.dart';

class FlutterMultiScrollTable extends StatefulWidget {
  final List<Widget> scrollableColumnHeader;
  final List<List<Widget>> scrollableColumnChildren;
  final List<List<Widget>> fixedColumnChildren;
  final List<Widget> fixedColumnHeader;
  final double totalWidth;
  final double? height;
  final bool isAscending;

  const FlutterMultiScrollTable({
    super.key,
    required this.scrollableColumnHeader,
    required this.totalWidth,
    this.height = 500,
    required this.scrollableColumnChildren,
    required this.fixedColumnChildren,
    this.isAscending = true,
    required this.fixedColumnHeader,
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

    _isHeaderScrolling = true;

    if (_headerScrollController.hasClients &&
        _horizontalScrollController.hasClients) {
      _horizontalScrollController.jumpTo(_headerScrollController.offset);
    }

    _isHeaderScrolling = false;
  }

  void _sortColumn() {
    setState(() {
      // Sort all fixed columns
      List<List<Widget>> sortedFixedColumns = [];
      for (var fixedColumn in widget.fixedColumnChildren) {
        fixedColumn.sort((a, b) {
          final textA = Utils.getTextFromWidget(a);
          final textB = Utils.getTextFromWidget(b);
          final comparisonResult = Utils.compareTexts(textA, textB);
          return widget.isAscending ? comparisonResult : -comparisonResult;
        });
        sortedFixedColumns.add(fixedColumn);
      }

      // Sort all scrollable columns
      List<List<Widget>> sortedScrollableColumns = [];
      for (var scrollableColumn in widget.scrollableColumnChildren) {
        scrollableColumn.sort((a, b) {
          final textA = Utils.getTextFromWidget(a);
          final textB = Utils.getTextFromWidget(b);
          final comparisonResult = Utils.compareTexts(textA, textB);
          return widget.isAscending ? comparisonResult : -comparisonResult;
        });
        sortedScrollableColumns.add(scrollableColumn);
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
    double totalFixedWidth = 0;
    for (var cell in widget.fixedColumnHeader) {
      if (cell is EachCell) {
        totalFixedWidth += cell.width ?? 0.0;
      }
    }

    List<Widget> fixedColumns = [];
    List<Widget> scrollableColumns = [];
    for (int i = 0; i < widget.scrollableColumnHeader.length; i++) {
      if (i < widget.fixedColumnHeader.length) {
        fixedColumns.add(SizedBox(
          width: (widget.fixedColumnHeader[i] as EachCell).width,
          child: widget.scrollableColumnHeader[i],
        ));
      } else {
        scrollableColumns.add(widget.scrollableColumnHeader[i]);
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => _sortColumn(),
                child: SizedBox(
                  width: totalFixedWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: widget.fixedColumnHeader,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        width: double.infinity,
                        child: const Divider(
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: GestureDetector(
                  onTap: () => _sortColumn(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        key: const Key("header"),
                        scrollDirection: Axis.horizontal,
                        controller: _headerScrollController,
                        child: Row(
                          children: widget.scrollableColumnHeader,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        width: double.infinity,
                        child: const Divider(
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: widget.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              key: const Key("data"),
              scrollDirection: Axis.vertical,
              controller: _verticalScrollController,
              child: Row(
                children: [
                  Row(
                    children:
                        List.generate(widget.fixedColumnHeader.length, (index) {
                      return FixedColumn(
                        width: (widget.fixedColumnHeader[index] as EachCell)
                                .width ??
                            0.0,
                        fixedColumns: widget.fixedColumnChildren[index],
                      );
                    }),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _horizontalScrollController,
                      child: Row(
                        children: List.generate(
                            widget.scrollableColumnChildren.length, (index) {
                          return ScrollableColumn(
                            width: 100,
                            scrollableColumns:
                                widget.scrollableColumnChildren[index],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
