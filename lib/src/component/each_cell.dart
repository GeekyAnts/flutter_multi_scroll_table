import 'package:flutter/material.dart';

class EachCell extends StatelessWidget {
  const EachCell({
    Key? key,
    required this.text,
    this.isHeader = false,
    this.width,
    this.height,
    this.textStyle,
    this.isLeftAlign = false,
    this.backgroundColor,
    this.padding,
    this.border,
    this.borderRadius,
    this.margin,
  }) : super(key: key);
  final String text;
  final bool isHeader;

  final bool isLeftAlign;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    double containerWidth = width ?? 50;

    return Container(
      height: height ?? 40,
      alignment: isHeader ? Alignment.bottomCenter : Alignment.center,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      key: UniqueKey(),
      width: containerWidth,
      child: Center(
        child: Text(
          text,
          style: textStyle ??
              const TextStyle(
                height: 1,
                color: Colors.black,
              ),
          textAlign: isLeftAlign ? TextAlign.left : TextAlign.center,
        ),
      ),
    );
  }
}
