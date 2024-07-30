import 'package:flutter/material.dart';

/// A widget that represents a single cell in a table.
/// It can be used for both header and data cells with various customization options.
class EachCell extends StatelessWidget {
  /// Creates an [EachCell] widget.
  ///
  /// The [text] parameter must not be null.
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

  /// The text content of the cell.
  final String text;

  /// Whether the cell is a header cell. Default is false.
  final bool isHeader;

  /// Whether the text should be left-aligned. Default is false.
  final bool isLeftAlign;

  /// The width of the cell.
  final double? width;

  /// The height of the cell.
  final double? height;

  /// The text style of the cell content.
  final TextStyle? textStyle;

  /// The background color of the cell.
  final Color? backgroundColor;

  /// The padding inside the cell.
  final EdgeInsetsGeometry? padding;

  /// The margin outside the cell.
  final EdgeInsetsGeometry? margin;

  /// The border of the cell.
  final BoxBorder? border;

  /// The border radius of the cell.
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
