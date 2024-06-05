import 'package:flutter/material.dart';
import 'package:flutter_multi_scroll_table/src/component/each_cell.dart';

import 'component/fixed_column.dart';
import 'component/scrollable_column.dart';

class FlutterMultiScrollTable extends StatefulWidget {
  final List<Widget> columns;
  final List<Widget> scrollableColumnChildren;
  final List<Widget> fixedColumnChildren;
  final double fixedColumnWidth;
  final double totalWidth;
  final double? height;
  final String? fixedColumnName;

  const FlutterMultiScrollTable({
    super.key,
    required this.columns,
    this.fixedColumnName,
    required this.totalWidth,
    this.height = 500,
    required this.fixedColumnWidth,
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
  bool _isScrolling = false;
  @override
  void initState() {
    _horizontalScrollController = ScrollController();
    _headerScrollController = ScrollController();
    _verticalScrollController = ScrollController();

    _horizontalScrollController.addListener(_syncScroll);
    _headerScrollController.addListener(_syncScroll);
    super.initState();
  }

  void _syncScroll() {
    if (_isScrolling) return;

    _isScrolling = true;

    if (_horizontalScrollController.hasClients &&
        _headerScrollController.hasClients) {
      if (_horizontalScrollController.position.isScrollingNotifier.value) {
        _headerScrollController
            .animateTo(
              _horizontalScrollController.offset,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            )
            .whenComplete(() => _isScrolling = false);
      } else if (_headerScrollController.position.isScrollingNotifier.value) {
        _horizontalScrollController
            .animateTo(
              _headerScrollController.offset,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            )
            .whenComplete(() => _isScrolling = false);
      } else {
        _isScrolling = false;
      }
    }
  }

  @override
  void dispose() {
    _horizontalScrollController.removeListener(_syncScroll);
    _headerScrollController.removeListener(_syncScroll);

    _horizontalScrollController.dispose();
    _headerScrollController.dispose();
    _verticalScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: widget.fixedColumnWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EachCell(
                    text: widget.fixedColumnName ?? "",
                    height: 45,
                    isHeader: true,
                    width: widget.fixedColumnWidth,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    width: widget.fixedColumnWidth,
                    child: const Divider(
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
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
                    width: widget.columns.length * 60,
                    child: const Divider(
                      color: Colors.grey,
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
            key: const Key("data"),
            scrollDirection: Axis.vertical,
            controller: _verticalScrollController,
            child: Row(
              children: [
                FixedColumn(
                  width: widget.fixedColumnWidth,
                  fixedColumnName: widget.fixedColumnName,
                  rows: widget.fixedColumnChildren,
                ),
                const SizedBox(
                  width: 0,
                ),
                ScrollableColumn(
                  width: widget.totalWidth - widget.fixedColumnWidth,
                  rows: widget.scrollableColumnChildren,
                  scrollController: _horizontalScrollController,
                  columns: widget.columns,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
