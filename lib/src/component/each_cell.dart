import 'package:flutter/material.dart';

class EachCell extends StatelessWidget {
  const EachCell(
      {Key? key,
      required this.text,
      this.isHeader = false,
      this.width,
      this.height,
      this.textStyle,
      this.isLeftAlign = false})
      : super(key: key);
  final String text;
  final bool isHeader;

  final bool isLeftAlign;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    double containerWidth = width ?? 50;

    return Container(
        height: height ?? 45,
        alignment: isHeader ? Alignment.bottomCenter : Alignment.center,
        key: UniqueKey(),
        width: containerWidth,
        child: Text(text,
            style: textStyle ??
                const TextStyle(
                  height: 1,
                  color: Colors.black,
                ),
            textAlign: isLeftAlign ? TextAlign.left : TextAlign.center));
  }
}
