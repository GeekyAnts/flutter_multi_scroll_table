import 'package:flutter/material.dart';

class ScrollableColumn extends StatefulWidget {
  final List<Widget> columns;
  final double? width;
  final List<Widget> rows;

  const ScrollableColumn({
    Key? key,
    required this.scrollController,
    required this.columns,
    required this.width,
    required this.rows,
  }) : super(key: key);

  final ScrollController? scrollController;

  @override
  State<ScrollableColumn> createState() => _ScrollableColumnState();
}

class _ScrollableColumnState extends State<ScrollableColumn> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: widget.scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   // height: 45.toHeight,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         mainAxisSize: MainAxisSize.max,
            //         children: [...widget.columns],
            //       ),
            //       const SizedBox(height: 5),
            //       Container(
            //         padding: const EdgeInsets.symmetric(vertical: 2),
            //         width: widget.width ?? widget.columns.length * 100,
            //         child: const Divider(
            //           color: Colors.grey,
            //           height: 1,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
                width: widget.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...widget.rows],
                ))
          ],
        ),
      ),
    );
  }
}
