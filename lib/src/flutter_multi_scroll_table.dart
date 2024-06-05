import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/src/component/each_cell.dart';

import 'component/fixed_column.dart';
import 'component/scrollable_column.dart';

class FlutterMultiScrollTable extends StatefulWidget {
  final List<Widget> columns;
  final List<Widget> scrollableColumnChildren;
  final List<List<Widget>> fixedColumnChildren;
  final List<double> fixedColumnWidths;
  final List<String>? fixedColumnTitles;
  final double totalWidth;
  final double? height;

  const FlutterMultiScrollTable({
    super.key,
    required this.columns,
    this.fixedColumnTitles,
    required this.totalWidth,
    this.height = 500,
    required this.fixedColumnWidths,
    required this.scrollableColumnChildren,
    required this.fixedColumnChildren,
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
    double totalFixedWidth = widget.fixedColumnWidths.reduce((a, b) => a + b);

    List<Widget> fixedColumns = [];
    List<Widget> scrollableColumns = [];
    for (int i = 0; i < widget.columns.length; i++) {
      if (i < widget.fixedColumnWidths.length) {
        fixedColumns.add(SizedBox(
          width: widget.fixedColumnWidths[i],
          child: widget.columns[i],
        ));
      } else {
        scrollableColumns.add(widget.columns[i]);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
              children: List.generate(widget.fixedColumnWidths.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EachCell(
                      text: widget.fixedColumnTitles?[index] ?? "",
                      height: 45,
                      isHeader: true,
                      width: widget.fixedColumnWidths[index],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      width: widget.fixedColumnWidths[index],
                      child: const Divider(
                        height: 1,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    key: const Key("header"),
                    scrollDirection: Axis.horizontal,
                    controller: _headerScrollController,
                    child: Row(
                      children: [...widget.columns],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    width: (widget.columns.length -
                            widget.fixedColumnWidths.length) *
                        60,
                    child: const Divider(
                      height: 1,
                    ),
                  ),
                ],
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
                      List.generate(widget.fixedColumnWidths.length, (index) {
                    return FixedColumn(
                      width: widget.fixedColumnWidths[index],
                      fixedColumnName: widget.fixedColumnTitles?[index],
                      rows: widget.fixedColumnChildren[index],
                    );
                  }),
                ),
                const SizedBox(
                  width: 0,
                ),
                ScrollableColumn(
                  width: widget.totalWidth - totalFixedWidth,
                  rows: widget.scrollableColumnChildren,
                  scrollController: _horizontalScrollController,
                  columns: scrollableColumns,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
